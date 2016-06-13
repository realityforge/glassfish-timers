# Release Process

Each application (or service) has a slightly different release process. The release process may require approval from
the business owner and may require additional steps that are not yet automated (such as uploading reports
to SQL Server Reports Server). However this document attempts to document the common aspects of the release
process.

## Concepts

Each application requires releases of multiple _facets_. For example a release may involve:

* Creating or migrating a database.
* Adding or updating destinations on a message broker.
* Deploying a ``.war`` file (or other deployable unit) to [GlassFish](GlassFish.md).
* Updating the monitoring system with new checks and probes etc.
* Updating load balancer with new routes.

Each of these are represented by a separate _facet_. The ``dbt`` facet is responsible for updating the database
server, the ``openmq`` facet is responsible for updating the message broker, the ``glassfish`` facet updates the
GlassFish domain(s) and the ``monitor`` facet updates the monitoring system, etc.

The applications are released using the [Chef](http://chef.io) system automation framework. We describe each
application using a series of recipes and databags.

The application's configuration within a environment is primarily defined in an application data bag item in the ``applications`` data bag. The data bag
item typically defines an object literal for each _facet_, a bag of application specific configuration under the key
``config`` as well as the following top level keys. Configuration common to all environments is defined in [Templates][], described further down.

* *id*: A unique ID for the data bag that matches the file name. By convention we use "*type*_*chef_environment*".
* *type*: Unique key for the application.
* *chef_environment*: The chef environment in which application instance is deployed.
* *nodes*: An array of strings indicating the nodes and order in which the nodes are converged during a release.
Note: This is only required due to inability of release process to determine these nodes automatically and this
requirement may be removed in a future release.
* *enabled*: A flag set to true to indicate application should be deployed. If this key is not set, then the
release process defaults it to true.

An example of an application data bag:

```json
{
  "id": "myapp_development",
  "type": "myapp",
  "chef_environment": "development",
  "nodes": [
    "DEVmq.example.com",
    "DEVsql.example.com",
    "DEVappserver.example.com"
  ],
  "enabled": "true",
  "monitor": {
    "template_version": "2"
  },
  "glassfish": {
    "domain": "appserver",
    "template_version": "6"
  },
  "openmq": {
    "template_version": "5"
  },
  "dbt": {
    "priority": 40,
    "instance_key": "appsdb",
    "major_version": 3,
    "username": "myapp_rw",
    "password": "myapp_password",
    "template_version": "3",
    "import_on_create": true
  },
  "config": {
    "plugin": "myapp-extender"
  }
}
```

## Templates

Templates are used as way of abstracting and reusing a chunk of configuration across multiple applications,
environments or nodes. Consider the scenario where a application is deployed to multiple environments; development,
uat, training and production. This application is likely to have similar glassfish configurations in each environment.
In this scenario the common configuration could be abstracted out into a template. The _facet_ configuration in the
``applications`` data bag item for the application would then reference the template.

Templates are stored in the ``templates`` data bag and must have the following top level keys.

* *id*: A unique ID for the data bag that matches the file name. By convention we use "*template_type*_*application*_*version*".
* *application*: Unique key for the application.
* *template_type*: A key identifying the _type_ of the template, usually the same name as the associated facet.
* *version*: A unique key within the scope of *application* and *template_type* that identifies a particular version
of the template. This is usually a monotonically increasing number.

The templates also have 1 or more additional top level keys that contain the shared configuration. These subkeys
are defined by the template type.

```json
{
  "id": "glassfish_myapp_v6",
  "application": "myapp",
  "template_type": "glassfish",
  "version": "6",
  "config": {
    ...
  }
}
```

Each facet within the application instance identifies which templates to use based on the presence of the top level
``type`` key and the sub-key ``template_version`` in the facet configuration. Consider the following application
configuration which would load the above template named ``glassfish_myapp_v6``.

```json
{
  ...
  "type": "myapp",
  ...
  "glassfish": {
    "template_version": "6",
    ...
  },
  ...
}
```

Note: There are some scenarios where a template is not associated with an application or a facet but we have not
settled on a concrete pattern by which we select the templates and versions to retrieve configuration from. An
example of this is the domain _template type_ that can be blended into a GlassFish domain based on a hash that
maps "application" keys to versions.

### GlassFish Template

The GlassFish templates are used by applications and require referencing from application instances.

#### Facet Configuration

The facet should include the following additional keys:

* *domain*: This specifies a symbolic key identifying which particular glassfish domain the application should be deployed to.
* *javamail_environment*: The environment from which to grab the email service. Only used if *javamail_resource* is specified.

The configuration of the facet should look something like:

```json
{
  ...
  "type": "myapp",
  ...
  "glassfish": {
    "domain": "mydomain",
    "template_version": "6"
  },
  ...
}
```

#### Template Structure

The template has the following keys:.

* *package_url*: A url to the war file for the application. The url may include the symbol ``$VERSION`` that is
replaced with the actual version of the application when the template is blended into domain configuration.
* *context_root*: The context root of the application. If not specified, it will default to ``/*application*``.
* *jms_resource*: By default if an application is configured to use the openmq facet then the openmq facet will
create a jms connection factory resource named using the pattern "*application*/jms/ConnectionFactory". This key makes
it possible for the operator to specify the actual resource name. Set this to null to disable the creation of the
resource altogether.
* *define_jms_destinations*: If an application has an openmq facet that defines destinations in the associated template
then the glassfish facet will automatically create `admin_objects` for each destination based naming them using the
convention "*application*/jms/*destination_jndi_name*".
* *javamail_resource*: If true or a string, then a javamail resource will be defined for the application. If set to a
string then that will be the JNDI name of resource, otherwise it will be "*application*/mail/session".
* *jdbc_resource*: By default if an application is configured to use the dbt facet then the dbt facet will
create a jdbc resource named using the pattern "*application*/jdbc/*pascalCase(application)*". This key makes it possible
for the operator to specify the actual resource name. Set this to null to disable the creation of the resource altogether.
* *publish_service*: By default the automation will publish the application urls and endpoints to the service
directory. This optional configuration key allows the operator to disable this publishing by setting it to `false`.
This is done when there is more complex logic surrounding the publishing of the service.
* *endpoints*: This optional key provides a mechanism for adding additional attributes to the service publication. The
values are interpolated before adding them as attributes. The following values can be interpolated:
    * `{{internal_url}}`: The url to the application for accessing by internal applications and users.
    * `{{public_url}}`: The url to the application for accessing by public applications and users.
    * `{{internal_url}}`: The url to the root directory for accessing by internal applications and users.
    * `{{public_url}}`: The url to the root directory for accessing by public applications and users.
    * `{{config:AAAA}}`: The value of the configuration key `AAAA` under the ``config`` key in the application configuration. The `AAAA`
* *config*: This optional key provides a contains a chunk of configuration that is blended into the configuration
of the domain. The structure of this configuration is not described anywhere and you will need to look at the existing
examples for inspiration.

The config section often has a _before_ hook that specifies a recipe to run prior to attempting to deploy the
application. This allows the developer to write some basic ruby code that can customize the deploy for the application.

A sample template that includes the minimal configuration is:

```json
{
  "id": "glassfish_myapp_v6",
  "application": "myapp",
  "template_type": "glassfish",
  "version": "6",
  "package_url": "http://repo.example.com/releases/myapp/myapp/$VERSION/myapp-$VERSION.war",
  "config": {
    "recipes": {
      "before": {
        "mycookbook::myapp_v6": {}
      }
    }
  }
}
```

A minimal recipe ``myapp_v6`` should be added to the ``mycookbook`` cookbook. It will typically be used to
perform per-application customizations of jdbc, mail or jms resources (or file system resources). Look
at the existing recipes for inspiration.

### Dbt Template

Dbt is our database automation infrastructure and the facet is used to configure each applications individual
database. Each application that contains a database publishes a dbt jar that contains all the scripts to create
our databases.

#### Facet Configuration

The facet supports the following additional keys:

* *instance_key*: This specifies a symbolic key identifying which particular database server the database
should be created on.
* *database_name*: This _optional_ key specifies the name of the database created. If not specified the
database name defaults to the value "*database_key*_*major_version*". It should only be specified when *database_key*
is not specified.
* *database_key*: This _optional_ key specifies the a unique key for the database from which the database name is
derived. It should only be specified when *database_name* is not specified. If not specified it is derived from the
constantized name of the application key.
* *major_version*: This identifies _major_ version of the database. The major version should match the major_version
encoded into the database jar. A change of the major version requires a recreation of the database.
* *enforce_version_match*: A boolean flag indicating whether whether a difference between the major_version defined
in the facet configuration and the major_version encoded in the dbt jar should result in a failed chef run. Defaults
to true if key unspecified.
* *recreate_on_minor_version_delta*: A boolean flag indicating whether a change in minor version should force a
recreate of the database. Defaults to false. Is only useful to use in the development environment.
* *username*: The username of the application level database user. If not set defaults to "*application_key*_rw".
* *password*: The password of the application level database user.
* *import_on_create*: A flag indicating whether the dbt import process should run when the database is created.
Defaults to true.
* *last_database*: The _optional_ key that specifies the database to import from. Must only be set if *import_on_create*
is true. If not set defaults to "*database_key*_*major_version - 1*"
* *collation*: This _optional_ key defines the database collation for sql server and defaults to 'SQL_Latin1_General_CP1_CS_AS'.
* *priority*: This _optional_ key is used to order the database management operations. Lower values will
result in database being sorted earlier. The value defaults 100 if not specified.
* *linked_databases*: This _optional_ key is a hash that maps a key to a database name. This mapping is supplied to
dbt during the creation and import processes and is only used if dbt jar requires reference to another database.
* *linked_application_databases*: This _optional_ key is a hash that maps a key to an application key. The application
must have a dbt facet from which a database name is derived. This mapping is merged with the `linked_databases`
configuration and passed to dbt during the creation and import processes.
* *linked_service_databases*: This _optional_ key is a hash that maps a key to an service key. The service
must be a database service from which a database name is extracted. This mapping is merged with the `linked_databases`
configuration and passed to dbt during the creation and import processes.

```json
{
  ...
  "type": "myapp",
  ...
  "dbt": {
    "priority": 40,
    "instance_key": "appsdb",
    "major_version": 3,
    "username": "myapp_rw",
    "password": "myapp_password",
    "template_version": "3",
    "import_on_create": true
  },
  ...
}
```

#### Template Structure

TODO

### OpenMQ Template

OpenMQ is the message broker in use and this OpenMQ template is used as an application facet. The template/facet
allows you to declare queues, topics, access_rules and accounts to be added to the message broker.

#### Facet Configuration

The facet supports the following additional keys:

* *username*: The username of the broker user. No user is created if not specified.
* *password*: The password of the broker user. Must be null unless username is specified.

```json
{
  ...
  "type": "myapp",
  ...
  "openmq": {
    "template_version": "6",
    "username": "Myapp",
    "password": "secret"
  },
  ...
}
```

#### Template Structure

The template has a single additional top level element named ``config`` that contains a chunk of configuration
that is blended into the configuration of the domain. The structure of this configuration is not described anywhere
and you will need to look at the existing examples for inspiration. However there are a few important sections that
are common across our applications.

There is an additional section ``destinations`` that contains details of all the destination that the application
uses. The literal has the following keys:

* *version*: The version of the destination to use.
* *permission*: The permission needed by the application. One of ``read``, ``write`` or ``readwrite``.
* *jndi_name*: The name of the jndi resource used in GlassFish etc. If not specified defaults to "**application**/jms/**destination_type**/**name**".

A sample template is:

```json
{
  "id": "openmq_myapp_v1",
  "application": "myapp",
  "template_type": "openmq",
  "version": "1",
  "destinations": {
    "Myapp.MyQueue": {
      "version": "2.0",
      "permission": "write"
    },
    "Myapp.Comms": {
      "version": "1.0",
      "permission": "readwrite",
      "jndi_name": "myapp/jms/queue/LegacyComms"
    },
    "Myapp.MyOtherQueue": {
      "version": "1.0",
      "permission": "write"
    }
  }
}
```

#### Destination Definition

TODO

### Monitor Template

The monitor template is the template used by our monitoring system (Sauron) to determine how to publish
the endpoints that need to be monitored. It is an application facet.

#### Facet Configuration

The template requires no additional configuration other than the ``template_version`` key. For example:

```json
{
  ...
  "type": "myapp",
  ...
  "monitor": {
    "template_version": "3"
  },
  ...
}
```

#### Template Structure

TODO

### Domain Template

TODO

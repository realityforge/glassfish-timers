# Local Configuration

Before an application can be developed and run it is important to configure the local environment.
The easiest way is to copy the template files and customize them for local development.

For most projects there is a single configuration file that needs to be updated via:

    $ cp config/application.example.yml config/application.yml
    $ vi config/application.yml

For older projects that use [Glassfish](GlassFish.md) you can customize the environment via the
following. Note: Modern redfish-based projects store all the configuration in `config/application.yml`.

    $ cp config/local.example.sh config/local.sh
    $ vi config/local.sh

Most projects will attempt to derive configuration from environment variables if it is not defined in
the `config/application.yml` configuration file. Typically developers are expected create a files
containing configuration for particular databases, message brokers, keycloak etc. These scripts can either
be called from the `~/.bashrc` script or manually run by the user if they are switching between environments.

i.e `~/.environments.d/common.local.sh` like:

    unset DOCKER_DNS
    
    unset DB_SERVER_PORT
    unset DB_SERVER_HOST
    unset DB_SERVER_INSTANCE
    unset DB_DEFAULT_INSTANCE
    unset DB_SERVER_USERNAME
    unset DB_SERVER_PASSWORD

    export CONFIG_ALLOW_HOSTNAME=true
    export GLASSFISH_HOME=/Users/username/Applications/payara
    
    export OPENMQ_HOST=localhost
    
    export RPTMAN_ENDPOINT=http://sqlssrs.example.com/webservice
    export RPTMAN_DOMAIN=example.com
    export RPTMAN_USERNAME=username
    export RPTMAN_PASSWORD=password
    
    export KEYCLOAK_REALM=MyRealm
    export KEYCLOAK_REALM_PUBLIC_KEY="MI..."
    export KEYCLOAK_AUTH_SERVER_URL="http://id.example.com/"
    export KEYCLOAK_ADMIN_PASSWORD=password
    export KEYCLOAK_TOKEN="ey..."

i.e `~/.environments.d/sqlserver.sh` like:

    source ~/.environments.d/common.local.sh

    export DB_TYPE=
    export DB_SERVER_USERNAME=admin
    export DB_SERVER_PASSWORD=secret
    export DB_SERVER_HOST=sqlserver.example.com

i.e `~/.environments.d/postgres.sh` like:

    source ~/.environments.d/common.local.sh

    export DB_TYPE=pg
    export DB_SERVER_USERNAME=admin
    export DB_SERVER_PASSWORD=secret
    export DB_SERVER_HOST=127.0.0.1

# Install GlassFish/Payara

The app server of choice is Payara/GlassFish. [Payara Server](http://www.payara.co.uk/) is a drop in replacement for
GlassFish Server with the peace of mind of quarterly releases containing enhancements, bug fixes and patches to
upstream GlassFish Server and dependent libraries including Tyrus, Eclipse Link, Jersey and others. The version of
Payara we currently use is `4.1.1.162 (Full Java EE)`.

## Download Payara

The product can be downloaded from [http://www.payara.co.uk/downloads](http://www.payara.co.uk/downloads).

This should be downloaded into the directory `~/Applications` and then run:

    $ unzip payara-4.1.1.162.zip && mv payara41 payara-4.1.1.162

Create a symlink called `payara` to the longer directory name.

    $ ln -s ~/Applications/payara-4.1.1.162 ~/Applications/payara

## Configuring the shell path

The only other action required is to add Payara's components to the path for the shell. The simplest way to do this
is to append the following line to `~/.bashrc`.

    export PATH=$PATH:~/Applications/payara/mq/bin:~/Applications/payara/glassfish/bin

## Configuring and Managing Domains

GlassFish has the concept of domains that are isolated instances of GlassFish that can be started and stopped
independently. Most projects start up a separate domain from all projects so that they can developed in isolation
from other projects. Occasionally a project will require the existance of a domain managed by another project and
will deploy artifacts into the other projects domain but this will be documented in the projects README.

Projects will typically have a script `config/setup.sh` that can be sourced to create the domain with all the
settings required for the project. If present the domain should be able to be created by:

    $ source config/setup.sh

## Operating GlassFish from the command-line

The domain will typically have the same name as the project. After the domain is created you can start and stop the
project and deploy the application from the command line using a command sequence similar to the following. (For
the sake of the example let us assume the project's name is `myproject` and it creates a war file to deploy.

    # Start the domain
    $ asadmin start-domain myproject

    # Deploy the webapp
    $ asadmin deploy --name myproject --contextroot myproject --force=true target/myproject-server/myproject-*.war

    # Stop the domain
    $ asadmin stop-domain myproject

## Operating GlassFish from the IDE

However it is more likely that you will be operating GlassFish from within the IDE. The IntelliJ IDEA projects that
are generated from Buildr automatically define configurations for starting and debugging GlassFish from the IDE.
Typically all you need to do is run the correct Payara configuration and the IDE will compile the app, start up
payara and deploy the application ready for interacting with.

Due to a bug in IDEA, the first time you open a project after creating the domain you will notice a cross over the
configuration, indicating it is invalid. You need to click on "Edit Configuration"  and click on the "Fix" button
next to the _"Debug settings are invalid or not suitable for local development"_ warning at the bottom of the dialog.

Some projects may allow the deployment of the local project into an already running (a.k.a. remote) domain
instance. If this is the case the configuration will be prefixed with the word _Remote_. When using remote
configurations, you should **never** try to run the configuration in debug mode as this will not work and
may crash GlassFish.

## GlassFish URLs

By default, each domain starts up http listeners at the following urls:

* [http://localhost:8080/](http://localhost:8080/) - The application web server
* [https://localhost:8181/](https://localhost:8181/) - The application web server behind ssl
* [http://localhost:4848/](http://localhost:4848/) - The Management Console

So you can typically find the application for the project `myproject` at [http://localhost:8080/myproject](http://localhost:8080/myproject).

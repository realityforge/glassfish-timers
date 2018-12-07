# Local Configuration

Before an application can be developed and run it is important to configure the local environment.
The easiest way is to copy the template files and customize them for local development.

For most projects there is a single configuration file that needs to be updated via:

    $ cp config/application.example.yml config/application.yml
    $ vi config/application.yml

However for the vast majority of projects this is not required if the correct environment variables are
configured. The build system will automatically copy `config/application.example.yml` to `config/application.yml`
and attempt to derive additional configuration from environment variables. Developers are expected create bash
scripts containing environment variable configuration for particular databases, message brokers, keycloak etc.
These scripts can either be called from the `~/.bashrc` script or manually run by the user if they are switching
between environments.

i.e `~/.environments.d/common.local.sh` like:

    unset DOCKER_DNS

    export MS_DB_SERVER_HOST=sqlserver.example.com
    export MS_DB_SERVER_USERNAME=admin
    export MS_DB_SERVER_PASSWORD=secret
    unset MS_DB_SERVER_PORT

    export PG_DB_SERVER_HOST=127.0.0.1
    export PG_DB_SERVER_USERNAME=admin
    export PG_DB_SERVER_PASSWORD=secret
    unset PG_DB_SERVER_PORT

    export CONFIG_ALLOW_HOSTNAME=true
    export GLASSFISH_HOME=/Users/username/Applications/payara

    export OPENMQ_HOST=localhost

    export RPTMAN_ENDPOINT=http://sqlssrs.example.com/ReportServer
    export RPTMAN_DOMAIN=example.com
    export RPTMAN_USERNAME=username
    export RPTMAN_PASSWORD=password

    export KEYCLOAK_REALM=MyRealm
    export KEYCLOAK_REALM_PUBLIC_KEY="MI..."
    export KEYCLOAK_AUTH_SERVER_URL="http://id.example.com/"
    export KEYCLOAK_ADMIN_PASSWORD=password
    export KEYCLOAK_SERVICE_USERNAME=YourUsername
    export KEYCLOAK_SERVICE_PASSWORD=YourPassword

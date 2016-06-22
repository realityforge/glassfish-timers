# Local Configuration

Before an application can be developed and run it is important to configure the local environment.
The easiest way is to copy the template files and customize them for local development.

For projects projects that use [Glassfish](GlassFish.md) you can customize the environment via:

    $ cp config/local.example.sh config/local.sh
    $ vi config/local.sh

For projects that use dbt to manage the database you may need to customize the database configuration via:

    $ cp config/database.example.yml config/database.yml
    $ vi config/database.yml

However more recently the projects have been updated to simplify configuration so that dbt will automatically
copy the database example file if no configuration is present. The example configuraiton then uses environment
variables to store all the information such as which database servers to use etc. Typically developers are expected
create a files containing configuration for particular databases. These scripts can either be called from the
`~/.bashrc` script or manually by the user if they are switching between environments.

i.e `~/.environment/sqlserver.sh` like:

    export DB_TYPE=
    export DB_SERVER_USERNAME=admin
    export DB_SERVER_PASSWORD=secret
    export DB_SERVER_HOST=sqlserver.example.com

i.e `~/.environment/postgres.sh` like:

    export DB_TYPE=pg
    export DB_SERVER_USERNAME=admin
    export DB_SERVER_PASSWORD=secret
    export DB_SERVER_HOST=127.0.0.1

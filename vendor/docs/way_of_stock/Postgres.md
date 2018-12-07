# Overview

Postgres is used as the database in several projects. _Postgres_ must be at least version 9.3 and must have
the _PostGis_ extension enabled. We also use _pgAdmin III_ as the GUI to explore the development and production
databases.

Note: Installation of Postgres is installs the "pg" library used to talk to Postgres database. This library
is primarily used by the pg gem dependency.

## Installing

### OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install postgis

This will install the Postgres server, Postgres client libraries and the Postgis extension.

The _pgAdmin_ application can be installed by the OSX App Store application.

### Linux Instructions

Under Linux you need to install postgres from a custom repository. This is because there is not a
current version of _PostGis_ in the default repositories. So first you should uninstall any version
of _Postgres_ that is installed.

    $ sudo apt-get remove -f libpq-dev postgres postgres-contrib

Then add the custom repository:

    $ sudo sh -c 'echo "deb https://launchpad.net/~ubuntugis/+archive/ppa/ trusty main" > /etc/apt/sources.list.d/postgis.list'

Then you need to install postgres with postgis:

    $ sudo apt-get install postgresql-9.3-postgis-2.1

The ligpq-dev library is also required, as it is a gem dependency for building projects that use Postgres DB.

    $ sudo apt-get install libpq-dev

The _pgAdmin III_ client can be installed from the Ubuntu Software Centre.

## Starting

By default _Postgres_ is not running. So you need to start it prior to use.

Under OSX, it can be started with:

    $ postgres -D /usr/local/var/postgres &

Under linux use:

    $ sudo service postgresql start

## Base Configuration

Each individual project is responsible for setting up the individual databases as appropriate for the project.
However it is necessary to setup a global superuser that cna create databases. Ensure the database is running
and run the following commands, as appropriate.

Under OSX:

    $ echo CREATE ROLE \"stock-dev\" WITH PASSWORD \'letmein\' CREATEDB SUPERUSER LOGIN\; | psql postgres

Under Linux:

    $ echo CREATE ROLE \"stock-dev\" WITH PASSWORD \'letmein\' CREATEDB SUPERUSER LOGIN\; | sudo -u postgres psql postgres

## Verify Install

To verify the install, the easiest way is to start the server and open the console using `sudo -u postgres psql postgres`
on Linux or `psql postgres` on OSX. Then type the query `SELECT postgis_full_version();`. It should return something
similar to; `POSTGIS="2.1.7" GEOS="3.4.2" PROJ="Rel. 4.8.0" GDAL="GDAL 1.10.1" LIBXML="2.9.1" LIBJSON="UNKNOWN" RASTER`. This
may fail with inability to find application in which case you will need to create the extension via `CREATE EXTENSION postgis;`

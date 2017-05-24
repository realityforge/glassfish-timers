# Sqlserver on Docker

Sqlserver is now available running as a linux container through docker. This is usually sufficient for
development purposes. Rather than connecting to a local windows VM or remote windows machine it can be faster
to use a local docker instance. As of April 2017, report services is not available on the docker instance.
If you need to use "Enterprise Manager" or "SSRS" you will need to use your existing approaches but for other
circumstances use the docker image to ease development.

## Local Configuration

The [Local Configuration](LocalConfiguration.md) for sql server needs to be setup first. `DB_SERVER_USERNAME`
should be set to `sa`, `DB_SERVER_PORT` should be set to `1433` and `DB_SERVER_PASSWORD` must be complex
enough to pass sql servers password checks which means _"At least 8 characters including uppercase, lowercase
letters, base-10 digits and/or non-alphanumeric symbols."_

## Starting the SQL Server Instance

To prepare docker for running sql server it needs to have sufficient memory (i.e. ~3-4GB) and running a modern
version of docker. Then you just need to run the following command.

    $ docker run -e 'ACCEPT_EULA=Y' -e SA_PASSWORD=$DB_SERVER_PASSWORD -p 1433:1433 --name sqlserver -d microsoft/mssql-server-linux

## Running sql shell against the instance

To run a sqlshell that references the instance

    $ docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $DB_SERVER_PASSWORD

## More documentation

If you need more documentation, see microsoft: https://github.com/Microsoft/mssql-docker/tree/master/linux/preview

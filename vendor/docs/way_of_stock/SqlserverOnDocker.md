# Sqlserver on Docker

Sqlserver is now available running as a linux container through docker. This is usually sufficient for
development purposes. Rather than connecting to a local windows VM or remote windows machine it can be faster
to use a local docker instance. As of April 2017, report services is not available on the docker instance.
If you need to use "Enterprise Manager" or "SSRS" you will need to use your existing approaches but for other
circumstances use the docker image to ease development.

## Local Configuration

The [Local Configuration](LocalConfiguration.md) for sql server needs to be setup first. `MS_DB_SERVER_USERNAME`
should be set to `sa`, `MS_DB_SERVER_PORT` should be set to `1433` and `MS_DB_SERVER_PASSWORD` must be complex
enough to pass sql servers password checks which means _"At least 8 characters including uppercase, lowercase
letters, base-10 digits and/or non-alphanumeric symbols."_

## Starting the SQL Server Instance

To prepare docker for running sql server it needs to have sufficient memory (i.e. ~3-4GB) and running a modern
version of docker. Then you just need to run the following commands. Note: we also create a volume so that backups
can be stored onto the volume and easily purged at a later date if needed.

    $ docker volume create SqlServerBackups
    $ docker run -e 'ACCEPT_EULA=Y' -e SA_PASSWORD=$MS_DB_SERVER_PASSWORD --mount source=SqlServerBackups,target=/SqlServerBackups -e TZ=Australia/Sydney -p 1433:1433 --name sqlserver -d microsoft/mssql-server-linux

## Running sql shell against the instance

To run a sqlshell that references the instance

    $ docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $DB_SERVER_PASSWORD

## Default language for login

By default the Default Language for the server will be US English.  To change this execute the following to change to British English.
    
    TSQL> exec sp_configure 'default language', 23
    TSQL> reconfigure

Upon creation the Language for the 'sa' login will be US English, and this overrides the default for the server.  To change the login to British English do:

    TSQL> ALTER LOGIN sa WITH DEFAULT_LANGUAGE=British

Changes in language will only take place at the start of a new session/connection to the database server.

## Restoring backups

To restore a SQL Server backup you first copy the backup onto the image via:

    docker cp /path/to/MYDB.bak sqlserver:/SqlServerBackups/MYDB.bak

Then you need to run the `sqlcmd` to perform backup. Typically the backup was taken from a windows machine so
you will need to move the logical files within the backup to files on the local filesystem during the backup
process. The way to do this looks something like:

    docker exec sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $MS_DB_SERVER_PASSWORD -Q "RESTORE DATABASE [MYDB] FROM DISK = N'/SqlServerBackups/MYDB.bak' WITH MOVE 'MYDB' TO '/var/opt/mssql/data/MYDB.mdf', MOVE 'MYDB_log' TO '/var/opt/mssql/data/MYDB.ldf'"

Finally it is a good practice to remove the backup so that it does not hang around and bloat your image. This is
done via:

    docker exec sqlserver rm /SqlServerBackups/MYDB.bak

It should be noted that under linux it may be possible to use a "bind" mount volume (i.e. mount a local volume) and
make the backup available in local directory. Due to limitations of docker under OSX this is not possible.

## More documentation

If you need more documentation, see microsoft: https://github.com/Microsoft/mssql-docker/tree/master/linux/preview

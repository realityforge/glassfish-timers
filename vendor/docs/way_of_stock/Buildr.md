# Buildr

[Apache Buildr](http://buildr.apache.org) is a ruby based build and automation tool. While local development
tends to occur within the [Intellij IDEA](IntellijIDEA.md) IDE, Buildr is used to automate the build on
the build box. Buildr is also used to download project dependencies, generate IDE project files and many other
local automation tasks.

There is a pdf guide available for Buildr at [http://buildr.apache.org/buildr.pdf](http://buildr.apache.org/buildr.pdf)
and you can list the tasks that are available in a specific project using:

    $ bundle exec buildr -T

You can restrict the list of tasks to those that begin with a prefix such as `dbt` via:

    $ bundle exec buildr -T dbt

However for some of the addons the only place to find documentation is to look at the code. The easiest way to
view this is using the github web interface such as [https://github.com/apache/buildr/tree/master/addon/buildr](https://github.com/apache/buildr/tree/master/addon/buildr).

Below are some simple instructions designed to get you started that include the idiosyncrasies of our
projects.

## How-to Build

To build without running tests you run the following command:

    $ bundle exec buildr clean package TEST=no

Most of our projects require creation and setup of databases before the tests will run. The simplest way to test
and package the project is to run the following command. It will create the databases and configure the required
support:

    $ bundle exec buildr ci:package

Sometimes this takes too long and you want to avoid creating and destroying the database each time. Another
approach is to do the setup in one step, and run the tests using a second command. Then second command can just be
re-run on demand. The exact setup commands will need to be extracted from the definition of `ci:package` task
that is typically defined in `tasks/ci.rake`.

However most projects will have a setup command like;

    $ bundle exec buildr ci:setup dbt:create

and a test command like;

    $ bundle exec buildr ci:setup test

## How-to Generate Source

Most projects use domgen to generate development artifacts such as source code and configuration files from a the
`architecture.rb` DSL. If the project uses domgen then you can regenerate the source code you can use the buildr
command:

    $ bundle exec buildr domgen:all

## How-to Generate IDE project files

You can generate the IDE configuration files via the buildr command:

    $ bundle exec buildr artifacts:sources idea:clean idea

This should configure the project ready for development. The project needs to rebuilt any time the dependencies
change or a new subproject is added to the project. It may not be necessary to run the `idea:clean` task unless the
project has changed significantly since the last rebuild of the project files.

### Running Tests within IDE

It should be noted that to run the tests from within the IDE you need to have have created the required databases.
This will vary project to project, some will have no databases while others will require several. However for most
projects the test databases can be created via:

    $ bundle exec buildr dbt:create DBT_ENV=test

Some projects also include integration tests where a war file is deployed to an embedded Payara server. In which case
it may be necessary to build the war package prior to running the integration tests from within the IDE. This can
typically be done with a command similar to the following. See the project README for further directions.

    $ bundle exec buildr myproject:server:package TEST=no

## How-to do Pre-Commit checks

Before pushing changes to the central source code repository it is expected that the developer runs the pre-commit
checks. These checks typically perform source code analysis and verify that the database definition is valid. The
easiest way to run the checks is to use the following command:

    $ bundle exec buildr dev:checks

This the pre-commit checks and opens the source code analysis reports in the browser for visual inspection.

## SQL Server versus Postgres builds

Several projects are capable of building either SQL Server compatible libraries or Postgres compatible libraries.
Typically the libraries default to SQL Server compaibility and can be switched to Postgres compatibility by
setting the environment variable `DB_TYPE` to `pg`. As the generated JPA artifacts are DB-specific, the project
will need to be rebuilt, domgen re-run and the artifacts repackaged when you change the `DB_TYPE` variable. i.e

Regenerate the domgen files:

    $ DB_TYPE=pg bundle exec buildr clean domgen:all

Rebuild the IntelliJ IDEA project files:

    $ DB_TYPE=pg bundle exec buildr artifacts:sources idea

Rebuild the project and install it in the local repository:

    $ DB_TYPE=pg bundle exec buildr ci:setup install
    
## Bash completion

Bash completion can be added through http://github.com/jcosmo/buildr-bash-completion

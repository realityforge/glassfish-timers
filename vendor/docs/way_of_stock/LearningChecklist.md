# Learning Checklist

This document is meant to outline a pathway to learn the basics about the stocksoftware specific tools
and processes we use day to day.

# Stage 1

* Define Simple Buildr project:
    * Ensure ruby environment for project is configured.
        * StockSoftware [Ruby](Ruby.md) documentation.
        * Manually create a `.ruby-version` file with 2.1.3 as the version dependency.
        * Create a Gemfile to define dependency on buildr.
        * StockSoftware [Ruby Gems](http://guides.rubygems.org/rubygems-basics/) documentation.
        * Run `buildr install` to get all the needed dependencies.

    * Package a basic war file.
        * StockSoftware [Buildr](Buildr.md) documentation.
        * Manually create the `buildfile` to be used by buildr.
        * Generate a war file using buildr.

    * JAX-RS endpoint that uses a simple CDI service to emit hello world.
        * Follow this document structure https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html
        * Run `buildr idea` to prepare the project for Idea.
        * Create the build.yaml file wherein the library dependencies will be defined.
        * Create the classes.
        * Recreate the war file.
        * Deploy using `asadmin deploy --name <name> --contextroot <root url> <path/war-file>`.

    * Use testng to test service.
        * Add `test.using :testng` in the buildfile.
        * Create the test classes.
        * Run the tests through buildr.

* Define `setup.sh` for local glassfish
    * StockSoftware [Glassfish](GlassFish.md) documentation.
    * Create `config/setup/sh`.

* Define project on Jenkins without deploying to Development
    * Get the fisg/architecture repository
    * Add into architecture/.chef your chef .pem file.
    * Define a new job in the fisg-jenkins cookbook: `cookbooks/fisg-jenkins/libraries/fisg_jenkins.rb`.
    * Run `knife cookbook upload --force fisg-jenkins` to upload cookbook.
    * Run `./xpiceweasel.rb  --converge DEVtools | sh` for Jenkins to pick up the updated cookbook.
    * Back in your own project, create task `ci:package` in `tasks/ci.rake`.

# Stage 2

* Define chef infrastructure for project:
    * Read through the [ApplicationRelease](ApplicationRelease.md) documentation.
    * Define a single glassfish template.
    * Define an application data bag item.

* Enhance Jenkins job definition to include a "Deploy to Development" job.

* Observe application deployed in Sauron

# Stage 3

* Use domgen to define service interface:
    * Braid in domgen.
    * Add in `domgen.rake` and `idea_patch.rake` into the tasks folder.
    * Define project in `architecture.rb`.
    * Enable `ejb` facet in domgen repository.
    * Update `buildfile` and define a task for Domgen.
    * Configure domgen buildr tasks to generate source.
    * Replace service interface with domgen defined service.
    * Use domgen generated base ejb test for service.
    * Update jenkins job definition to collect tests

# Stage 4

* Use dbt to define automate database creation:
    * Braid in dbt.
    * Enable `mssql` facet in domgen repository.
    * Configure dbt buildr tasks to create database.
    * Configure domgen buildr tasks to generate database sql.
    * Setup template files for database configuration.
    * Generate `db` project that generates db jar.
* Use domgen to define entity/table in database:
    * Enable `jpa` facet in domgen repository.
    * Update `setup.sh` script to configure databases.
    * Define a single entity in domgen repository.
    * Configure domgen buildr tasks to generate source for jpa entities and jpa base test classes.
    * Run `buildr dbt:create DBT_ENV=<environment name>` to create the needed database schema.
* Update chef infrastructure for project:
    * Define a single database template.
    * Update application data bag item to deploy database.

* Observe application deployed in Sauron

# Stage 5

* Integrate Checkstyle into Buildr.
* Integrate PMD into Buildr.
* Integrate Spotbugs into Buildr.
* Define `ci:commit` task.
* Update Jenkins to add commit job.

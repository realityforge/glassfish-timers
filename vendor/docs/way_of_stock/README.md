# Way of Stock Software

The purpose of this repository is to document the standard tools and processes that are used
at Stock Software. It is neither complete nor set in stone and it is expected to
evolve and be refined over time.

## Business Tools and Resources

* [Tide](Tide.md): Timesheet tool.
* [KeePass](KeePass.md): Password locker where shared passwords and credentials are stored.
* [Telecube](Telecube.md): 1300 Support line management.

## Basic Host Setup

Before starting any project, please ensure that your shell is correctly setup.

* [Install Homebrew](Homebrew.md) (Mac Only)
* [Setup git](Git.md)
* [Setting up the shell prompt](ShellPrompt.md)

## Environment Setup

The following documents describe environment setup for our projects. Not all projects use all of these
features but they likely to be required by many projects.

* [Install ruby and rbenv](Ruby.md)
* [Install java](Java.md)
* [Install freetds library](FreeTDS.md)
* [Install Postgres](Postgres.md)
* [Install gem dependencies](GemDependencies.md)
* [Install IntelliJ IDEA](IntellijIDEA.md)
* [Install GlassFish](GlassFish.md)
* [Install Docker](Docker.md)

## How-to Configure the Application

The following documents describe configuration of the application during development.

* [Local Application Configuration](LocalConfiguration.md)

## Essential Development Tools

The following documents describe some of the essential tools in use in our projects. They should give a starting
point for using the tools within the context of our projects.

* [Braid](Braid.md): Vendor branch management tool.
* [Buildr](Buildr.md): Build automation tool.
* [GreenMail](Greenmail.md): An SMTP server that holds emails insteading of sending.
* [NodeJS](NodeJS.md): Javascript runtime environment and ecosystem.
* [QBroswerLite](QBrowserLite.md): OpenMQ Message Broker Destination browser.
* [Postgres](Postgres.md): Postgres database server.
* [Zim](Zim.md): Tool to automate changes to source code repositories.
* [Hub](Hub.md): Tool for interacting with GitHub from the command line.
* [Rptman](Rptman.md): Tool to automate interaction with SQL Server Reports Server.

## Development Processes

The documents describe in shorthand some of our development processes.

* [Application Releases](ApplicationRelease.md): How we release our applications.

## Learning Goals

Most people should be able to perform the basic tasks required by our projects. To start to promote this
we are trying to develop a series of checklists to document what you should be able to do:

* [Learning Checklist](LearningChecklist.md)

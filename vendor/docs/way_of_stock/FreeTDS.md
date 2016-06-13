# Installing Freetds

Freetds is the native library used to talk to SQL Server database. It is only required if the project
talks to SQL Server. It is primarily used by the `tiny_tds` gem dependency.

## OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install freetds

## Linux Instructions

To install under linux we install the package via;

    $ sudo apt-get install freetds-dev

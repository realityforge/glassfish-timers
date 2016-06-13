# Installing Gem dependencies

A project that requires gem dependencies to be installed will have a `Gemfile` and a `Gemfile.lock` in the base
directory of the project. The `Gemfile` declares the required dependencies while the `Gemfile.lock` is
generated when a specific set of dependencies are selected to fulfill the dependencies.

Before the Gem dependencies are installed, it is important to install any required native libraries.
Typically this means installing the native database drivers ([Postgres](Postgres.md) or [FreeTDS](FreeTDS.md)
libraries) and [java](Java.md). Note that `JAVA_HOME` **MUST** be set if java is used by a Gem dependency.

[Bundler](http://gembundler.com/) is the tool used to install and manage gem dependencies. You _may_ need to
install `bundler` if it is not already installed. You can check if if `bundler` is installed by running
`gem list | grep bundler` and expect to see it output to the console if it is installed.

    $ gem install bundler
    $ rbenv rehash

To install Buildr and the other gem dependencies you then need to do the following.

    $ cd ../path/to/project
    $ bundle install
    $ rbenv rehash

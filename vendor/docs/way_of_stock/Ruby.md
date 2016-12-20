# Overview

We use `rbenv`, a ruby version manager, to manage the ruby versions used by each project. To install
ruby we first install `rbenv` then issue commands to rbenv to install the correct versions of ruby.

Ruby and `rbenv` are required by a project when there exists a file named `.ruby-version` in the base
directory of the project.

## Installing rbenv

### OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install rbenv
    $ brew install ruby-build

### Linux Instructions

Under Linux you need to run;

    $ sudo apt install rbenv ruby-build

## Installing ruby

Most projects use the _2.3.1_ version of ruby. The version of ruby used by a project can be determined by
reading the contents of the `.ruby-version` in the base directory of the project. Replace _2.3.1_ in the
following instructions with the version that the project actually uses.

Under Linux, first install required dependencies:

    $ sudo apt-get install -y libxml2-dev libssl-dev libreadline-dev zlib1g-dev

To install ruby, it is as simple as:

    $ rbenv install 2.3.1

Note that if the 2.3.1 version is not listed when you do:

    $ rbenv install --list

Then under OSX you may need to do a:

    $ brew upgrade ruby-build

While under Linux you may need to do:

    $ sudo apt install ruby-build

Under Linux you _may_ need to install the dependency:

    $ sudo apt-get install -y g++

# NodeJS

NodeJS is a javascript environment for the server and command line. We primarily use it to run
tooling such as the Less compiler.

## Install NodeJS

### OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install node

### Linux Instructions

To install under linux we install the package via;

    $ sudo apt-get install python-software-properties
    $ sudo apt-add-repository ppa:chris-lea/node.js
    $ sudo apt-get update
    $ sudo apt-get install nodejs

## Using Node Package Manager

[NPM] (from https://npmjs.org/) or the Node Package Manager is the standard mechanism for installing
tools and libraries in the Node ecosystem. Node packages can either be installed globally or locally
to the project. As all of our projects use a limited subset of tools we tend to install globally which
means passing the `-g` flag to `npm`.

An example of how to install Less.js a CSS preprocessor that we have used is:

    $ sudo npm install -g less
    $ sudo npm install -g less-plugin-clean-css

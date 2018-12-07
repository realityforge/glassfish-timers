# Hub

Hub is a command line tool for interacting with GitHub from the command line. Mostly it is used
for creating pull requests from the command line. See the [manual](https://hub.github.com/hub.1.html)
for a full list of commands it offers.

## Install Hub

Hub will need to be installed.

### OSX Instructions

Under OSX with [Homebrew](Homebrew.md) installed you can install via;

    $ brew update
    $ brew install hub

### Linux Instructions

To install under linux we install the package via;

    $ sudo apt-get install hub

TODO: Check this

## Creating a pull request from the command line

The most common use of hub is to create a pull request from the command line. This can be done
using commands such as:

    # while on a topic branch called "feature":
    $ git pull-request
    [ opens text editor to edit title & body for the request ]

    # explicit title, pull base & head:
    $ git pull-request -m "Implemented feature X" -b master -h feature

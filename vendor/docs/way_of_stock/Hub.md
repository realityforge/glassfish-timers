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

## Configuring Basic Settings

As we use hub with an Enterprise GitHub there is a few additional steps that we need take. First we
need to whitelist our github to enable interaction with it form the hub command. Do this via:

    $ git config --global --add hub.host git.fire.dse.vic.gov.au
    $ git config --global --add hub.host git

You can verify the settings are correctly set by listing the values using the command:

    $ git config --global -l

Next you will need to set up authentication credentials to interact with our enterprise github. This
involves creating a oauth token manually and then adding it into the configuration file `~/.config/hub`.
The token can be created by going to "Personal Oauth Tokens" section of the "Applications" page referenced
from the user configuration pages.

The configuration file `~/.config/hub` should look the following replacing the oauth token and username
as appropriate. It should be noted that this step is not needed with interacting with the public github
as the command will prompt you for appropriate credentials when the first action occurs.

    ---
    git.fire.dse.vic.gov.au:
    - oauth_token: MyToken
      user: MyUser
      protocol: http

## Creating a pull request from the command line

The most common use of hub is to create a pull request from the command line. This can be done
using commands such as:

    # while on a topic branch called "feature":
    $ git pull-request
    [ opens text editor to edit title & body for the request ]

    # explicit title, pull base & head:
    $ git pull-request -m "Implemented feature X" -b master -h feature

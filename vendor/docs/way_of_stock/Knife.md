# Configuration for knife aka chef stuff!

## Prerequisites

    $ sudo apt-get install libxslt-dev

Clone the delwp-infrastructure project

    $ bundle install
    
    Note, if you have problems installing eventmachine on a Mac then you might need to do:
    $ bundle config build.eventmachine --with-cppflags=-I$(brew --prefix openssl)/include    

## DELWP: Register as a client
Browse to http://chef

Get an existing admin to log in and create an account for you, matching your ubuntu user name
The user should be set as an admin

Copy the private key to ~/dev/infrastructure/.chef/YOUR_UBUNTU_USER_NAME.pem

## Set up environment variables
export set CHEF_USER=YOUR_UBUNTU_USER_NAME

(You probably want to put this into your .bashrc)

## Bash shell expansion
Bash expansions for common knife commands make your life easier!

    $ kcb   => knife cookbook upload ...
    $ kdba  => knife data bag from file application ...
    $ kdbdb => knife data bag from file databases ...
    $ kdbd  => knife data bag from file destinations ...
    $ kdbs  => knife data bag from file services ...
    $ kdbt  => knife data bag from file template ...
    $ kenv  => knife environment from file ...
    $ kdiff => xpiceweasel --diff

The script can be downloaded from [knife.sh](knife.sh). The contents can be appended to the `~/.bashrc` script
or you can place the script in a directory (i.e. `~/.bash.d`) and source it from the `~/.bashrc` script (i.e.
append `source ~/.bash.d/knife.sh` to the `~/.bashrc` script).

## Sample commands

To upload a cookbook

    $ knife cookbook upload <name>

To converge a node

    $ ruby xpiceweasel --converge NODENAME
    $ ruby xpiceweasel --converge NODENAME | bash

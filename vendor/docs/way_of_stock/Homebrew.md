# Install Homebrew

[Homebrew](http://mxcl.github.com/homebrew/) is the missing OSX package manager. In short it allows
the installation of software packages from the command line. The packages are often opensource packages
originally from the Linux ecosystem but this has expanded to include many OSX specific packages. The
applications are stored in the `/usr/local/Cellar` directory.

To install it simply run:

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

To update the list of packages available you can install you should issue the command:

    $ brew update

To list the packages installed run:

    $ brew list

To search for a new package with name containing the word _'gi'_ run:

    $ brew search gi

To install a package named _'git'_ run:

    $ brew install git

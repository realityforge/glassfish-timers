# Install Java

Most projects expect that java is installed and the ``JAVA_HOME`` is set to the correct location.
Currently most projects use Java 7 while some use Java 8.

## OSX Instructions

To install under OSX, simply download and run the installer from the Oracle JDK website.

For Java 7 you can visit the Oracle website:

<http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html>

Alternatively you can download it from a cached copy at:

<https://s3-ap-southeast-2.amazonaws.com/stocksoftware-installers/jdk7/mac/jdk-7u79-macosx-x64.dmg>

For Java 8 you can download the installer from:

<http://www.oracle.com/technetwork/java/javase/downloads/index.html>

Add the following snippet to `~/.bashrc`;

    export JAVA_HOME=$(/usr/libexec/java_home)

Run `~/.bashrc`;

    $ source ~/.bashrc

Unfortunately due to the way some java programs interact with OSX, they also require that the legacy Java 6
to be present even if it is not used. To install the Java6 JVM the package should be downloaded and installed
from `https://support.apple.com/kb/DL1572?locale=en_US`

## Linux Instructions

To install under linux we install the package from a custom repository. To setup the repository run:

    $ sudo apt-get install python-software-properties
    $ sudo add-apt-repository ppa:webupd8team/java
    $ sudo apt-get update

Then to install Java 7 run:

    $ sudo apt-get install oracle-java7-installer

Add the following snippet to `~/.bashrc`;

    export JAVA_HOME=/usr/lib/jvm/java-7-oracle

While to install Java 8 run:

    $ sudo apt-get install oracle-java8-installer

Add the following snippet to `~/.bashrc`;

    export JAVA_HOME=/usr/lib/jvm/java-8-oracle

Run `~/.bashrc`;

    $ source ~/.bashrc

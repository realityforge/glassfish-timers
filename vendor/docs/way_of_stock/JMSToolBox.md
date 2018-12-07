## JMSToolBox

Many of us are using JMSToolBox to interact with OpenMQ. The tool allows you to send messages to a
destination and to browse messages on an existing queue.

## Download and Install

Download the installer from [Sourceforge](https://sourceforge.net/projects/jmstoolbox/) and install into the
`~/Applications` directory. Under OSX some version need to have the execute bit set on command before
it can be run. This can be done via:

    $ chmod u+x ~/Applications/JMSToolBox.app/Contents/MacOS/JMSToolBox

## Run

If you are using JMSToolBox to view the local message broker and you have not customized the configuration
then the default configuration settings that can be used to connect are:

* **Host**: 127.0.0.1
* **Port**: 7676
* **Username**: admin
* **Password**: admin

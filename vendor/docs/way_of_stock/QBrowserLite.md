## QBrowserLite

Many of us are using QBrowserLite to interact with OpenMQ. The tool allows you to send messages to a
destination and to browse messages on an existing topic.

## Download and Install

Download the `.zip` file from `http://sourceforge.net/projects/qbrowserv2/files/` and unpack it into the
`~/Applications` directory.

## Run

The QBrowserLite script needs to be run from the installed directory otherwise the script will not be able
to find the required libraries. To run the program run a command such as:

    $ cd ~/Applications/qbrowser-X && ./run_open_mq.sh

If you are using QBrowserLite to view the local message broker and you have not customized the configuration
then the default configuration settings that can be used to connect are:

* **Host**: 127.0.0.1
* **Port**: 7676
* **Username**: admin
* **Password**: admin

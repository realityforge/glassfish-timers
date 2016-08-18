# Docker in Horizon

[Docker](https://www.docker.com/) is used to provide an increasing amount of the deployment infrastructure within
the DELWP Horizon space.

## Overview

Horizon has a bunch of Virtual Machines named ENVdocker##.  For example PRDdocker01.
These machines are running the Docker engine and are available for remote management via TLS.

These machines are set up via chef, using the infrastructure_v2 repository.

Assuming you have docker installed you can manage the containers on each of these nodes by setting a few environment
 variables, and getting hold of the client TLS certificate.

To make it easy to set these environment variables all the necessary config, and certificates, are are packaged up in
infrastructure_v2/administration.  In this directory you will find files named 'env_pd1.sh', or similar, which
set the necessary environment variables for each machine.  Just source the appropriate file and you are away.

    $ source ~/dev/infrastructure_v2/administration/env_dd1.sh
    $ docker ps
    $  CONTAINER ID        IMAGE                         COMMAND
    $  8fedc1dfaa69        logstash:2.3.4-1              "/docker-entrypoint.s"
    $  a5684edefbaf        stocksoftware/kibana          "/docker-entrypoint.s"
    $  6cc97da84544        stocksoftware/elasticsearch   "/opt/elasticsearch/b"

## docker.sh

The [docker.sh](docker.sh) file, if placed in your ~/.bash.d/ and executed appropriately will provide you with
some commands which make switching between the different docker VMs easier, and will update your prompt to indicate
which VM you are currently targetting.

Commands provided are:

    $ denv [node_env_file.sh]
    $ docker_env [node_env_file.sh]
    # default_docker

denv and docker_env are identical and will do tab-expansion for switching between VMs, assuming you have the infrastructure_v2
 project cloned to ~/Code

default_docker will unset all environment variables, leaving you pointing at your local docker installation

# Docker

[Docker](https://www.docker.com/) is the container management solution we are starting to use. It will become
the mechanism via which all of our applications are packaged and installed.

## Getting Started

Docker is an active project and rather than trying to replicate the instructions, the source website
is the best place to go look for instructions. There are specific instructions for [Linux](https://docs.docker.com/linux/),
[OSX](https://docs.docker.com/mac/) and [Windows](https://docs.docker.com/windows/).

The remaining section adds some additional notes that should help you getting started.

## Building an image

Assuming you are creating a docker image from a Dockerfile in a directory it is as simple as:

    $ docker build -t image_name path/to/dir

## Running an image

Images can be turned into running containers. There is a whole range of parameters that can be passed
to the run sub-command but a typical command is:

    $ docker run --rm --name my_container -i -t stocksoftware:ruby bash

## Bash Completion on a mac

See https://docs.docker.com/compose/completion/

    $ brew install bash-completion
    $ echo ". $(brew --prefix)/etc/bash_completion" >> ~/.bash_profile
    $ curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o ~/.bash.d/docker_completion.sh
    
    If you are not auto-running everything in ~/.bash.d
    $ echo ". ~/.docker_completion.sh" >> ~/.bash_profile

### Run-time DNS

Runtime dns can be specified by passing the `--dns DNS` parameter to the `docker run` command. If you are
using Redfish the easiest way to ensure this happens is to set the environment variable `DOCKER_DNS`.

## Docker Cheat Sheet

This is an extraction of the [wsargent Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet.git).

### Lifecycle

* [`docker create`](https://docs.docker.com/reference/commandline/create) creates a container but does not start it.
* [`docker rename`](https://docs.docker.com/engine/reference/commandline/rename/) allows the container to be renamed.
* [`docker run`](https://docs.docker.com/reference/commandline/run) creates and starts a container in one operation.
* [`docker rm`](https://docs.docker.com/reference/commandline/rm) deletes a container.
* [`docker update`](https://docs.docker.com/engine/reference/commandline/update/) updates a container's resource limits.

If you want a transient container, `docker run --rm` will remove the container after it stops.

If you want to map a directory on the host to a docker container, `docker run -v $HOSTDIR:$DOCKERDIR`..

If you want to remove also the volumes associated with the container, the deletion of the container must include the -v switch like in `docker rm -v`.

There's also a [logging driver](https://docs.docker.com/engine/admin/logging/overview/) available for individual containers in docker 1.10.  To run docker with a custom log driver (i.e. to syslog), use `docker run --log-driver=syslog`

### Starting and Stopping

* [`docker start`](https://docs.docker.com/reference/commandline/start) starts a container so it is running.
* [`docker stop`](https://docs.docker.com/reference/commandline/stop) stops a running container.
* [`docker restart`](https://docs.docker.com/reference/commandline/restart) stops and starts a container.
* [`docker pause`](https://docs.docker.com/engine/reference/commandline/pause/) pauses a running container, "freezing" it in place.
* [`docker unpause`](https://docs.docker.com/engine/reference/commandline/unpause/) will unpause a running container.
* [`docker wait`](https://docs.docker.com/reference/commandline/wait) blocks until running container stops.
* [`docker kill`](https://docs.docker.com/reference/commandline/kill) sends a SIGKILL to a running container.
* [`docker attach`](https://docs.docker.com/reference/commandline/attach) will connect to a running container.

Restart policies on crashed docker instances are [covered here](http://container42.com/2014/09/30/docker-restart-policies/).

### Info

* [`docker ps`](https://docs.docker.com/reference/commandline/ps) shows running containers.
* [`docker logs`](https://docs.docker.com/reference/commandline/logs) gets logs from container.  (You can use a custom log driver, but logs is only available for `json-file` and `journald` in 1.10)
* [`docker inspect`](https://docs.docker.com/reference/commandline/inspect) looks at all the info on a container (including IP address).
* [`docker events`](https://docs.docker.com/reference/commandline/events) gets events from container.
* [`docker port`](https://docs.docker.com/reference/commandline/port) shows public facing port of container.
* [`docker top`](https://docs.docker.com/reference/commandline/top) shows running processes in container.
* [`docker stats`](https://docs.docker.com/reference/commandline/stats) shows containers' resource usage statistics.
* [`docker diff`](https://docs.docker.com/reference/commandline/diff) shows changed files in the container's FS.

`docker ps -a` shows running and stopped containers.

### Import / Export

* [`docker cp`](https://docs.docker.com/reference/commandline/cp) copies files or folders between a container and the local filesystem..
* [`docker export`](https://docs.docker.com/reference/commandline/export) turns container filesystem into tarball archive stream to STDOUT.

### Executing Commands

* [`docker exec`](https://docs.docker.com/reference/commandline/exec) to execute a command in container.

To enter a running container, attach a new shell process to a running container called foo, use: `docker exec -it foo /bin/bash`.

## Images

Images are just [templates for docker containers](https://docs.docker.com/engine/understanding-docker/#how-does-a-docker-image-work).

### Lifecycle

* [`docker images`](https://docs.docker.com/reference/commandline/images) shows all images.
* [`docker import`](https://docs.docker.com/reference/commandline/import) creates an image from a tarball.
* [`docker build`](https://docs.docker.com/reference/commandline/build) creates image from Dockerfile.
* [`docker commit`](https://docs.docker.com/reference/commandline/commit) creates image from a container, pausing it temporarily if it is running.
* [`docker rmi`](https://docs.docker.com/reference/commandline/rmi) removes an image.
* [`docker load`](https://docs.docker.com/reference/commandline/load) loads an image from a tar archive as STDIN, including images and tags (as of 0.7).
* [`docker save`](https://docs.docker.com/reference/commandline/save) saves an image to a tar archive stream to STDOUT with all parent layers, tags & versions (as of 0.7).

### Info

* [`docker history`](https://docs.docker.com/reference/commandline/history) shows history of image.
* [`docker tag`](https://docs.docker.com/reference/commandline/tag) tags an image to a name (local or registry).

## Networks

Docker has a [networks](https://docs.docker.com/engine/userguide/networking/dockernetworks/) feature.  Not much is known about it, so this is a good place to expand the cheat sheet.  There is a note saying that it's a good way to configure docker containers to talk to each other without using ports.  See [working with networks](https://docs.docker.com/engine/userguide/networking/work-with-networks/) for more details.

### Lifecycle

* [`docker network create`](https://docs.docker.com/engine/reference/commandline/network_create/)
* [`docker network rm`](https://docs.docker.com/engine/reference/commandline/network_rm/)

### Info

* [`docker network ls`](https://docs.docker.com/engine/reference/commandline/network_ls/)
* [`docker network inspect`](https://docs.docker.com/engine/reference/commandline/network_inspect/)

### Connection

* [`docker network connect`](https://docs.docker.com/engine/reference/commandline/network_connect/)
* [`docker network disconnect`](https://docs.docker.com/engine/reference/commandline/network_disconnect/)

You can specify a [specific IP address for a container](https://blog.jessfraz.com/post/ips-for-all-the-things/):

```
# create a new bridge network with your subnet and gateway for your ip block
docker network create --subnet 203.0.113.0/24 --gateway 203.0.113.254 iptastic

# run a nginx container with a specific ip in that block
$ docker run --rm -it --net iptastic --ip 203.0.113.2 nginx

# curl the ip from any other place (assuming this is a public ip block duh)
$ curl 203.0.113.2
```

## Volumes

Docker volumes are [free-floating filesystems](https://docs.docker.com/userguide/dockervolumes/).  They don't have to be connected to a particular container.  You should use volumes mounted from [data-only containers](https://medium.com/@ramangupta/why-docker-data-containers-are-good-589b3c6c749e) for portability.

### Lifecycle

* [`docker volume create`](https://docs.docker.com/engine/reference/commandline/volume_create/)
* [`docker volume rm`](https://docs.docker.com/engine/reference/commandline/volume_rm/)

### Info

* [`docker volume ls`](https://docs.docker.com/engine/reference/commandline/volume_ls/)
* [`docker volume inspect`](https://docs.docker.com/engine/reference/commandline/volume_inspect/)

Volumes are useful in situations where you can't use links (which are TCP/IP only).  For instance, if you need to have two docker instances communicate by leaving stuff on the filesystem.

You can mount them in several docker containers at once, using `docker run --volumes-from`.

## Registry & Repository

A repository is a *hosted* collection of tagged images that together create the file system for a container.

A registry is a *host* -- a server that stores repositories and provides an HTTP API for [managing the uploading and downloading of repositories](https://docs.docker.com/userguide/dockerrepos/).

Docker.com hosts its own [index](https://hub.docker.com/) to a central registry which contains a large number of repositories.  Having said that, the central docker registry [does not do a good job of verifying images](https://titanous.com/posts/docker-insecurity) and should be avoided if you're worried about security.

* [`docker login`](https://docs.docker.com/reference/commandline/login) to login to a registry.
* [`docker logout`](https://docs.docker.com/reference/commandline/logout) to logout from a registry.
* [`docker search`](https://docs.docker.com/reference/commandline/search) searches registry for image.
* [`docker pull`](https://docs.docker.com/reference/commandline/pull) pulls an image from registry to local machine.
* [`docker push`](https://docs.docker.com/reference/commandline/push) pushes an image to the registry from local machine.

## Dockerfile

[The configuration file](https://docs.docker.com/reference/builder/). Sets up a Docker container when you run `docker build` on it.  Vastly preferable to `docker commit`.

### Instructions

* [.dockerignore](https://docs.docker.com/reference/builder/#dockerignore-file)
* [FROM](https://docs.docker.com/reference/builder/#from) Sets the Base Image for subsequent instructions.
* [MAINTAINER](https://docs.docker.com/reference/builder/#maintainer) Set the Author field of the generated images..
* [RUN](https://docs.docker.com/reference/builder/#run) execute any commands in a new layer on top of the current image and commit the results.
* [CMD](https://docs.docker.com/reference/builder/#cmd) provide defaults for an executing container.
* [EXPOSE](https://docs.docker.com/reference/builder/#expose) informs Docker that the container listens on the specified network ports at runtime.  NOTE: does not actually make ports accessible.
* [ENV](https://docs.docker.com/reference/builder/#env) sets environment variable.
* [ADD](https://docs.docker.com/reference/builder/#add) copies new files, directories or remote file to container.  Invalidates caches. Avoid `ADD` and use `COPY` instead.
* [COPY](https://docs.docker.com/reference/builder/#copy) copies new files or directories to container.
* [ENTRYPOINT](https://docs.docker.com/reference/builder/#entrypoint) configures a container that will run as an executable.
* [VOLUME](https://docs.docker.com/reference/builder/#volume) creates a mount point for externally mounted volumes or other containers.
* [USER](https://docs.docker.com/reference/builder/#user) sets the user name for following RUN / CMD / ENTRYPOINT commands.
* [WORKDIR](https://docs.docker.com/reference/builder/#workdir) sets the working directory.
* [ARG](https://docs.docker.com/engine/reference/builder/#arg) defines a build-time variable.
* [ONBUILD](https://docs.docker.com/reference/builder/#onbuild) adds a trigger instruction when the image is used as the base for another build.
* [STOPSIGNAL](https://docs.docker.com/engine/reference/builder/#stopsignal) sets the system call signal that will be sent to the container to exit.
* [LABEL](https://docs.docker.com/engine/userguide/labels-custom-metadata/) apply key/value metadata to your images, containers, or daemons.

### Security Tips

Since docker 1.11 you can easily limit the number of active processes running inside a container to prevent fork bombs. This requires a linux kernel >= 4.3 with CGROUP_PIDS=y to be in the kernel configuration.

    docker run --pids-limit=64

Also available since docker 1.11 is the ability to prevent processes to gain new privileges. This feature is in the linux kernel since version 3.5. You can read more about it in [this](http://www.projectatomic.io/blog/2016/03/no-new-privs-docker/) blog post.

    docker run --security-opt=no-new-privileges

Set the container to be read-only:

    docker run --read-only

Set volumes to be read only:

    docker run -v $(pwd)/secrets:/secrets:ro debian

Set memory and CPU sharing:

    docker -c 512 -mem 512m

## Useful commands

### Get IP address

    docker inspect -f '{{ .NetworkSettings.IPAddress }}' <container_name>

### Delete Stopped containers

    docker rm -v $(docker ps -a -q -f status=exited)

### Delete old containers

    docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm

### Delete Dangling images

    docker rmi $(docker images -q -f dangling=true)

### Delete dangling volumes

    docker volume rm $(docker volume ls -q -f dangling=true)

### Kill running containers

    docker kill $(docker ps -q)

### Monitor system resource utilization for running containers

    docker stats <container>

or for all containers

    docker stats

or for all containers by name

    docker stats $(docker ps --format '{{.Names}}')

### List images based on ancestor

    docker ps -a -f ancestor=stocksoftware/redfish

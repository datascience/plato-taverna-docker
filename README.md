# Plato Taverna Docker Image

The planning tool [Plato](http://ifs.tuwien.ac.at/dp/plato/) is a decision support tool that implements a solid preservation planning process and integrates services for content characterisation, preservation action and automatic object comparison in a service-oriented architecture to provide maximum support for preservation planning endeavours.

Preservation action, characterisation and quality assurance services can be based on [SCAPE Components](http://scp.openpreservation.org/). These annotated [Taverna](http://taverna.org.uk/) workflows provide a uniform interface for Plato to combine and execute SCAPE Components for planning experiments and to create an Executable Plan as part of the Preservation Plan. Taverna allows calling external tools and services, scripts and other useful functions and combine them in a graphical interface in the [Taverna Workbench](http://taverna.org.uk/download/workbench/). Plato uses the [Taverna Command Line Tool](http://taverna.org.uk/download/command-line-tool/) to execute preservation experiments.

To isolate experiments from the host and each other Taverna can be executed in a Docker container. This repository contains a Dockerfile for a container with Taverna Command Line and SCAPE Components to execute preservation experiments in Plato.

## Building the image

To build the docker image use the command

```
docker build -t plato-taverna .
```

Use `--no-cache` to avoid hitting docker's cache when rebuilding the image. This ensures that the image is built from the newest version of the base image and that the newest versions of the components are installed.

## Running the image

To execute the image run

```
docker run --rm plato-taverna:latest [parameters]
```

The image has Taverna's `executeworkflow` binary as [entrypoint](http://docs.docker.com/reference/builder/#entrypoint). Thus you can use the docker run command just like the Taverna Command Line Tool. To simplify this, you can add a script similar to [executeworkflow.sh](executeworkflow.sh) to your path.

Taverna is executed as user `taverna` with UID `2000` and group `taverna` with GID `2000`.

Folders can be mounted into the container as volumes to provide access to files on the host. Since docker shares file UIDs/GIDs with the host, make sure that a user with UID `2000` and GID `2000` has access to relevant files.

```
docker run --rm -v /tmp:/tmp -v /home/taverna:/home/taverna plato-taverna:latest [parameters]
```

## Interactive access
To gain interactive access to the image, override the entrypoint

```
docker run --rm -i -t --entrypoint /bin/bash plato-taverna:latest
```

You can also get root access by additionally overriding the user

```
docker run --rm -i -t --entrypoint /bin/bash -u 0 plato-taverna:latest
```

## Running as normal user
Since docker requires root access to run a container normal users have to `sudo` the command. To avoid entering a password, you can explicitely allow executing `docker run` with this image and predefined parameters without a password, e.g. by creating a file `/etc/sudoers.d/docker-taverna` containing

```
%docker-taverna ALL=(root) NOPASSWD: /usr/bin/docker run --rm plato-taverna\:latest*
```

# License
Plato Taverna Docker is released under [Apache version 2.0 license](LICENSE).

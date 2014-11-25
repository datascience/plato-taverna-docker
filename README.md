# Plato Taverna Docker Image

The planning tool [Plato](http://ifs.tuwien.ac.at/dp/plato/) is a decision support tool that implements a solid preservation planning process and integrates services for content characterisation, preservation action and automatic object comparison in a service-oriented architecture to provide maximum support for preservation planning endeavours.

Preservation action, characterisation and quality assurance services can be based on [SCAPE Components](http://scp.openpreservation.org/). These annotated [Taverna](http://taverna.org.uk/) workflows provide a uniform interface for Plato to combine and execute SCAPE Components for planning experiments and to create an Executable Plan as part of the Preservation Plan. Taverna allows calling external tools and services, scripts and other useful functions and combine them in a graphical interface in the [Taverna Workbench](http://taverna.org.uk/download/workbench/). Plato uses the [Taverna Command Line Tool](http://taverna.org.uk/download/command-line-tool/) to execute preservation experiments.

To isolate experiments from the host and each other Taverna can be executed in a Docker container. This repository contains a Dockerfile for a container with Taverna Command Line and SCAPE Components to execute preservation experiments in Plato.

## Installation

Pull the image from the [Plato Taverna Docker index](https://registry.hub.docker.com/u/datascience/plato-taverna-docker/). The image is build automatically from the [Plato Taverna Docker GitHub repository](https://github.com/datascience/plato-taverna-docker).

```
docker pull datascience/plato-taverna-docker:latest
```

Alternatively you can build the image locally using

```
docker build --tag="$USER/gitlab" .
```

Use `--no-cache` to avoid hitting docker's cache when rebuilding the image. This ensures that the image is built from the newest version of the base image and that the newest versions of the components are installed.

## Running the image

To execute the image run

```
docker run --rm datascience/plato-taverna-docker:latest executeworkflow [parameters]
```

This runs Taverna's executeworkflow binary in the container just like a local Taverna Command Line Tool. To simplify this, you can add a script similar to [executeworkflow.sh](executeworkflow.sh) to your path.

Taverna is executed as user `taverna` with UID `2000` and group `taverna` with GID `2000`.

Folders can be mounted into the container as volumes to provide access to files on the host. Since docker shares file UIDs/GIDs with the host, make sure that a user with UID `2000` and GID `2000` has access to relevant files.

```
docker run --rm -v /tmp:/tmp -v /home/taverna:/home/taverna datascience/plato-taverna-docker:latest [parameters]
```

## Interactive access
To gain interactive access to the image, run `/bin/bash` in an interactive docker container

```
docker run --rm -i -t datascience/plato-taverna-docker:latest /bin/bash
```

You can get root access by overriding the user

```
docker run --rm -i -t -u root datascience/plato-taverna-docker:latest /bin/bash
```

## Running as normal user
Since docker requires root access to run a container, normal users have to use `sudo`. To avoid entering a password, you can explicitely allow executing `docker run` with this image and predefined parameters without a password, e.g. by creating a file `/etc/sudoers.d/docker-taverna` containing

```
%docker-taverna ALL=(root) NOPASSWD: /usr/bin/docker run --rm datascience/plato-taverna-docker\:latest executeworkflow *
```

# License
Plato Taverna Docker is released under [Apache version 2.0 license](LICENSE).

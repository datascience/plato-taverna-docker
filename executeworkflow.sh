#!/bin/sh

sudo docker run --rm -v /tmp:/tmp -v /home/taverna:/home/taverna datascience/plato-taverna-docker:latest executeworkflow $@

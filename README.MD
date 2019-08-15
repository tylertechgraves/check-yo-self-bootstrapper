# check-yo-self-boostrapper

The check-yo-self-bootstrapper is a Docker container that
runs a single script (bootstrap.sh). That script is designed
to call the check-yo-self-api service which will load all employees
from the MySql database and to index those employees in
the Elasticsearch service.

This container is run as part of the check-yo-self-api's
docker-compose environment.  It is intended to create
the employees Elasticsearch index and to bootstrap Elasticsearch
index data automatically within the docker-compose environment
as it comes to live.

## Building the check-yo-self-bootstrapper Docker image

The `dockerize.sh` and `dockerize.ps1` scripts are used
to build the check-yo-self-bootstrapper Docker image.
Just choose one of the two scripts, based on the OS
you're running, and run it.

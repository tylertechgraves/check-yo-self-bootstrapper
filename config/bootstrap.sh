#!/bin/sh

if [ ! -z "$APICONTAINER" ]
then
    # To ensure we've given an istio sidecar time to bootstrap, we'll wait 2 seconds
    echo 'testing connection to api container'
    sh -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://${APICONTAINER}/health)" != "200" ]]; do sleep 1; done'
    echo 'connection to api successful'

    echo 'bootstrapping elasticsearch'
    curl -X POST "http://${APICONTAINER}/api/v1/Employees/ReindexAllEmployees" -d ""
fi
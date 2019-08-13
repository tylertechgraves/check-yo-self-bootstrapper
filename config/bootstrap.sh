#!/bin/sh

# If the container name has been set, then bootstrap that container
if [ ! -z "$CONSULCONTAINER" ]
then
    # To ensure we've given an istio sidecar time to bootstrap, we'll wait 2 seconds
    echo 'testing connection to consul'
    sh -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://${CONSULCONTAINER}/v1/kv/?keys)" != "200" ]]; do sleep 1; done'
    echo 'connection to consul successful'

    echo 'bootstrapping consul'
    curl --request PUT --data @/config/appsettings.json http://${CONSULCONTAINER}/v1/kv/environment.json -H "Content-Type:application/json"
fi

if [ ! -z "$MANIFESTCONTAINER" ]
then
    echo 'bootstrapping manifestservice'
    curl --request POST --data @/config/manifests.json http://${MANIFESTCONTAINER}/WebApplications -H "Content-Type:application/json"
fi

if [ ! -z "$APICONTAINER" ]
then
    # To ensure we've given an istio sidecar time to bootstrap, we'll wait 2 seconds
    echo 'testing connection to api container'
    sh -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://${APICONTAINER}/health)" != "200" ]]; do sleep 1; done'
    echo 'connection to api successful'

    echo 'bootstrapping elasticsearch'
    curl -X POST "http://${APICONTAINER}/api/Employees/ReindexAllEmployees" -d ""
fi
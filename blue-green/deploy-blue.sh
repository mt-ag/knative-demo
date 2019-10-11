#!/bin/bash

k.exe apply -f template/blue-deployment.yaml
export BLUE_REVISION_NAME=$(k.exe get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')
envsubst < "template/blue-deployment-route.yaml" | k.exe apply -f -
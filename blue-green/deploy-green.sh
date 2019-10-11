#!/bin/bash

export BLUE_REVISION_NAME=$(k.exe get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')
k.exe apply -f template/green-deployment.yaml
export GREEN_REVISION_NAME=$(k.exe get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')
envsubst < "template/green-deployment-route.yaml" | k.exe apply -f -
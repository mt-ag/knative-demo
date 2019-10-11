#!/bin/bash

export BLUE_REVISION_NAME=$(k.exe get route blue-green -o=jsonpath='{.status.traffic[0].revisionName}')
export GREEN_REVISION_NAME=$(k.exe get route blue-green -o=jsonpath='{.status.traffic[1].revisionName}')
envsubst < "template/0-100-route.yaml" | k.exe apply -f -
#!/bin/bash

# Install tekton-pipelines
k.exe apply --filename https://storage.googleapis.com/tekton-releases/latest/release.yaml

# Install klr go-runtime
k.exe apply -f https://raw.githubusercontent.com/triggermesh/knative-lambda-runtime/master/go-1.x/runtime.yaml


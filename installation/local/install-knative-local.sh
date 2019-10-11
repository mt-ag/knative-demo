#!/bin/bash

gloo.exe install knative --install-knative-version 0.9 --install-monitoring
k.exe apply -f template/local-domain.yaml
k.exe apply -f template/example-ksvc.yaml
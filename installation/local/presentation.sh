#!/bin/bash

. ../../demo-magic.sh
clear

p "\e[36mglooctl \e[39minstall knative --install-knative-version 0.9 --install-monitoring"
gloo.exe install knative --install-knative-version 0.9 --install-monitoring

p "\e[36mkubectl \e[39mapply -f template/local-domain.yaml"
k.exe apply -f template/local-domain.yaml

p "\e[36mkubectl \e[39mapply -f template/example-ksvc.yaml"
k.exe apply -f template/example-ksvc.yaml
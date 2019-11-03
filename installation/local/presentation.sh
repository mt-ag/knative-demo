#!/bin/bash

. ../../demo-magic.sh
clear

p "\e[36mglooctl \e[39minstall knative"
gloo.exe install knative

p "\e[36mkubectl \e[39mapply -f template/local-domain.yaml && \e[36mkubectl \e[39mapply -f template/enable-monitoring.yaml"
k.exe apply -f template/local-domain.yaml
k.exe apply -f template/enable-monitoring.yaml

p "\e[36mkubectl \e[39mapply -f https://github.com/knative/serving/releases/download/v0.9.0/monitoring-metrics-prometheus.yaml"
k.exe apply -f template/monitoring.yaml

p "\e[36mkubectl \e[39mapply -f template/example-ksvc.yaml"
k.exe apply -f template/example-ksvc.yaml

p "\e[36mkubectl \e[39mget ksvc"
k.exe get ksvc

p "\e[36mkubectl \e[39mport-forward -n knative-monitoring svc/grafana 30802:30802"
k.exe port-forward -n knative-monitoring svc/grafana 30802:30802
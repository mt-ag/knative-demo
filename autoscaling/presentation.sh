#!/bin/bash

. ../demo-magic.sh
clear

p "\e[36mkubectl \e[39mapply -f template/autoscale-go.yaml"
k.exe apply -f template/autoscale-go.yaml

p "\e[36mexport \e[39mURL=\$(kubectl get ksvc autoscale-go -o=jsonpath='{.status.url}')"
export URL=$(k.exe get ksvc autoscale-go -o=jsonpath='{.status.url}')

p "\e[36mhey \e[39m-z 5m -c 50 $URL?sleep=100&prime=10000&bloat=5"
hey.exe -z 1m -c 50 "$URL?sleep=100&prime=10000&bloat=5"

p "\e[36mkubectl \e[39mport-forward -n knative-monitoring svc/grafana 30802:30802"
k.exe port-forward -n knative-monitoring svc/grafana 30802:30802
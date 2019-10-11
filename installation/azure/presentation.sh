#!/bin/bash

. ../../demo-magic.sh
clear

p "\e[36mglooctl \e[39minstall knative --install-monitoring"
gloo.exe install knative --install-monitoring

p "\e[36mretrieving public ip address"
export PUBLIC_IP=""
while [ -z $PUBLIC_IP ]; do
  echo "\e[93m    ... Still waiting for LoadBalancer to receive public ip address\e[36m"
  export PUBLIC_IP=$(k.exe get svc knative-external-proxy -n gloo-system --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$PUBLIC_IP" ] && sleep 5
done
echo "\e[92mgot the public ip-address\e[36m"
sleep 5
clear

p "\e[36menvsubst \e[39m< template/azure-domain.yaml | \e[36mkubectl \e[39mapply -f -"
envsubst < "template/azure-domain.yaml" | k.exe apply -f -

p "\e[36mkubectl \e[39mapply -f template/example-ksvc.yaml"
k.exe apply -f template/example-ksvc.yaml

wait
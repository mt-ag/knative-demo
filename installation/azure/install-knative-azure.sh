#!/bin/bash

gloo.exe install knative --install-monitoring

export PUBLIC_IP=""
while [ -z $PUBLIC_IP ]; do
  echo "... Still waiting for LoadBalancer to receive public ip address"
  export PUBLIC_IP=$(k.exe get svc knative-external-proxy -n gloo-system --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$PUBLIC_IP" ] && sleep 5
done

envsubst < "template/azure-domain.yaml" | k.exe apply -f -
k.exe apply -f template/example-ksvc.yaml
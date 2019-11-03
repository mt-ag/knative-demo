#!/bin/bash

. ../demo-magic.sh
clear

p "\e[36mkubectl \e[39mapply -f template/blue-deployment.yaml"
k.exe apply -f template/blue-deployment.yaml

p "\e[36mexport \e[39mBLUE_REVISION_NAME=\$(kubectl get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')"
export BLUE_REVISION_NAME=$(k.exe get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')

p "\e[36menvsubst \e[39m< template/blue-deployment-route.yaml | kubectl apply -f -"
envsubst < "template/blue-deployment-route.yaml" | k.exe apply -f -

p "\e[36mkubectl \e[39mget routes"
k.exe get routes

p "\e[36mkubectl \e[39mapply -f template/green-deployment.yaml"
k.exe apply -f template/green-deployment.yaml

p "\e[36mexport \e[39mGREEN_REVISION_NAME=\$(kubectl get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')"
export GREEN_REVISION_NAME=$(k.exe get configurations blue-green -o=jsonpath='{.status.latestCreatedRevisionName}')

p "\e[36menvsubst \e[39m< template/green-deployment-route.yaml | kubectl apply -f -"
envsubst < "template/green-deployment-route.yaml" | k.exe apply -f -

p "\e[36menvsubst \e[39m< template/50-50-route.yaml | kubectl apply -f -"
envsubst < "template/50-50-route.yaml" | k.exe apply -f -

p "\e[36menvsubst \e[39m< template/0-100-route.yaml | kubectl apply -f -"
envsubst < "template/0-100-route.yaml" | k.exe apply -f -

p "\e[36mkubectl \e[39mport-forward -n knative-monitoring svc/grafana 30802:30802"
k.exe port-forward -n knative-monitoring svc/grafana 30802:30802
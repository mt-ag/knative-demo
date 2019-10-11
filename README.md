# K-Native Präsentation
Dieses Repository enthält eine Reihe von Vorführprojekten die K-Native vorstellen sollen.
Sie wurde ursprünglich für das Herbsttreffen der GSE in Berlin erstellt.

## Grundsätzliches zu K-Native
K-Native (Aussprache `Kay-Native`) ist Serverless-Framework das auf Kubernetes aufsetzt.
Ursprünglich entwickelt wurde K-Native von Google, um neben Anforderungen wie Skalierung vorallem die Portierbarkeit zu fokussieren.

## Anforderungen für die Skripte
* WSL 1.0 mit folgenden Kommandos:
  * `k.exe` ==> `kubectl`
  * `helm.exe` ==> `helm`
  * `hey.exe` ==> `hey`

## Installation
Die Installation von K-Native kann grundsätzlich auf jedem Kubernetes-Cluster erfolgen.
Es gibt zudem zwei prominente Installationsmethoden:

* **Installation mit Istio als Service-Mesh**
  * Benötigt den gesamten Istio-Stack
  * Anschließend Deployment aller Ressourcen über kubectl
* **Installation mit Gloo als API-Gateway**
  * API-Gateway ist leichtgewichtiger, bringt aber die Vorteile von Istio nicht mit
  * Installation über [gloo](https://github.com/solo-io/gloo), wie in der [K-Native Doku beschrieben](https://knative.dev/docs/install/knative-with-gloo/)

Im Rahmen dieser Präsentation wird ausschließlich `gloo` benutzt.

### Ausführen des Installationsskripts
Skripte für verschiedene Zielumgebungen befinden sich im Ordner `installation`.

* `installation/local` fokussiert die Installation auf einem auf dem eigenen PC virtualisierten Cluster
* `installation/azure` zeigt die Installation auf einem Kubernetes-Cluster auf der Azure-Cloud

In allen Installationsverzeichnissen befindet sich ein "normales" Shell-Script für die Installation wie auch eins das als Präsentationsskript dient.
Dieses Scrikte sind für das Ausführen auf dem WSL 1.0 (Bash on Windows) ausgelegt.
Die Skripte lassen sich aber mit überschaubarem Aufwand auf eine "richtige" Linux-Bash übertragen.

Das `presentation.sh`-Skript simuliert das Tippen des Befehls und wartet auf ein Enter zum ausführen.

## Beispielszenarien
### Initiales Deployment
Die Installationsskripte erzeugen ein Beispiel-Deployment.
Das kann gezeigt werden um zu zeigen, wie schnell der Einstieg fällt: `Hello World!`

### Blue-Green-Deployments
Zeigt wie sich Blue-Green-Deployments mit K-Native realisieren lassen.
Dafür wird manuell eine K-Native Configuration mit einer Route erstellt.
Anschließend wird die Configuration aktualisiert, damit eine zweite Revision besteht.
Der Gesamte Traffic an den Endpunkt läuft zu diesem Zeitpunkt jedoch noch auf die "Alte" Revision.
Anschließend wird der Traffic langsam von der alten auf die neue Instanz Geroutet (`100/0 -> 50/50 -> 0/100`).

### Autoscaling
Zeigt das automatische Skalieren von K-Native.
Es wird ein Beispiel-Service Deployt, der so konfiguriert ist, dass pro Service im Schnitt 10 Requests verarbeitet werden sollen.
Anschließend wird mit dem Tool [hey](https://github.com/rakyll/hey) Last auf dem System erzeugt (Es werden über eine Zeitspanne von 1 Minute 50 Requests an den Endpunkt aufrechterhalten).
Ein Blick auf die Pods zeigt anschließend das Hoch- und zurück auf Null-Skalieren des K-Native services.
Die Entwicklung lässt sich auch auf dem Monitoring-Dashboard beobachten.

### Lambda-Kompatiblität
TriggerMesh bietet ein OpenSource-Projekt namens [KLR (K-Native Lambda Runtime)](https://github.com/triggermesh/knative-lambda-runtime).
Diese Runtime ermöglicht das Bereitstellen von Lambda-Funktionen auf einer K-Native Installation.
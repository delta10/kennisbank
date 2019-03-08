---
title: "Aan de slag"
description: ""
weight: 20
menu:
  docs:
    parent: "Kubernetes"
---

#### Vereisten
Om aan de slag te gaan heb je toegang nodig tot een Kubernetes cluster. Dit kan een bestaand cluster zijn waar je toegang tot hebt. Heb je geen toegang tot een cluster, dan kun je zelf een cluster op je eigen computer opzetten door de handleiding [een lokaal cluster opzetten](../een-lokaal-cluster-opzetten/) te volgen.

Zorg vervolgens dat het programma [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) op je lokale computer geïnstalleerd staat. Met dit programma kunnen we eenvoudig verbinding te leggen met het cluster. Wanneer je een bestaand cluster gebruikt dan kun je van de beheerder de installatieinstructies krijgen die je nodig hebt om kubectl te laten werken. Wanneer je een lokaal cluster opzet dan configureert Docker Desktop of minikube je lokale omgeving zodat kubectl direct werkt.

Om te kijken of kubectl goed werkt met het cluster voer het volgende commando uit:

```bash
  kubectl cluster-info
Kubernetes master is running at https://35.204.252.212
GLBCDefaultBackend is running at https://35.204.252.212/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
Heapster is running at https://35.204.252.212/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at https://35.204.252.212/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
kubernetes-dashboard is running at https://35.204.252.212/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
Metrics-server is running at https://35.204.252.212/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
```

Ook kunnen we bekijken hoeveel nodes er in ons cluster actief zijn:

```bash
  kubectl get nodes
NAME                                         STATUS    ROLES     AGE       VERSION
gke-k8s-delta10-default-pool-8fdf11d8-1c1b   Ready     <none>    111d      v1.9.7-gke.11
gke-k8s-delta10-default-pool-a5eaece6-d0qv   Ready     <none>    111d      v1.9.7-gke.11
```

Onze kubectl configuratie werkt en we in ons cluster twee nodes die klaar zijn om werk op te pakken.

#### Het dashboard
Het Kubernetes dashboard kan gebruikt worden om een overzicht te krijgen van het cluster, nieuwe applicaties uit te rollen en eventuele problemen op te sporen van draaiende applicaties. Ook het gebruikt worden om bestaande Kubernetes resources (zoals Deployments, Jobs en DaemonSets enz.) aan te passen.

Gebruik het volgende commando om de proxy naar het cluster op te zetten:

```bash
  kubectl proxy
```

Gebruik vervolgens deze link om het dashboard te bekijken: [http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/cluster?namespace=default](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/cluster?namespace=default).

![Een schermafbeelding van het Kubernetes dashboard](/kubernetes/images/dashboard.png)

Op deze overzichtspagina zie je weer een lijst van nodes die actief zijn in het cluster en de verschillende gescheiden omgevingen, ook wel namespaces genoemd.

#### Een nieuwe applicatie uitrollen
Via het dashboard is het eenvoudig om een nieuwe applicatie uit te rollen. We klikken op "Deployments" en vervolgens rechtsboven op "+ Create". Via het tabblad "Create an app" kunnen we heel snel een nieuwe container uitrollen. Als voorbeeld gebruiken we de image `bartjkdp/hello-world`, een applicatie die een "Hello world" bericht toont. Vul de volgende gegevens in:

- App name: **hello-world**
- Container image: **bartj/hello-world:1.0.0**
- Number of pods: **1**
- Service: Internal, port en target port **5000**, **TCP**

![Een schermafbeelding van het create an app scherm](/kubernetes/images/create-application.png)

De container image komt overeen met de naam van de image op [DockerHub](https://dockerhub.com). Met de waarde "number of pods" kan ingesteld worden hoeveel kopieën van de applicatie opgestart worden in het cluster. Deze waarde kun je hoger maken als de applicatie voldoet aan de eisen van "[The Twelve-Factor-App](https://12factor.net/)" en je veel verkeer verwacht of wanneer je een hoge beschikbaarheid eist van de applicatie.

Druk vervolgens op "deploy" om applicatie op te starten. Via het tabblad Deployments kun je de voortgang volgen. Op het moment dat de vinkje voor de deployment op groen staat is de applicatie gereed.

#### Een applicatie inspecteren
Via het tabblad "Pods" kom je op het overzicht van alle pods, dit zijn de kopieeën van de verschillende deployments in je applicatie. Een pod kan weer bestaan uit één of meerdere containers die altijd samen gebundeld worden op één node.

We klikken nu op de hello-world pod en zien in het overzicht op welke pod deze node is opgestart. Rechtsboven kan met het knopje "Exec" en "Logs" ingelogd worden op de container en kunnen de logs van de container ingezien worden.

#### Toegang binnen het cluster
Via het tabblad "Services" zien we alle services die binnen het cluster aangeboden worden.

![Een schermafbeelding van het tabblad services](/kubernetes/images/services.png)

Omdat we bij het aanmaken van de applicatie hebben aangegeven dat we poort 5000 TCP beschikbaar willen maken is er automatisch een service **hello-world** toegevoegd. Je ziet in het overzicht ook het Cluster IP van deze service. Onder dit IP is deze service beschikbaar in het hele cluster. Daarnaast heeft Kubernetes ook automatisch een DNS verwijzing aangemaakt die gekoppeld is aan het Cluster IP. De service is dus ook onder de naam `hello-world` beschikbaar.

Wanneer er meerdere pods opgestart zijn voor dezelfde service dan wordt verkeer via het Cluster IP automatisch verdeeld over de beschikbare pods.

#### Toegang buiten het cluster
**Let op: deze stap werkt alleen op een cluster waar een ingress controller ingesteld is. Als je een cluster hebt opgezet met minikube of Docker desktop, dan is er standaard geen ingress controller ingesteld.**

Om de applicatie ook toegankelijk te maken buiten het cluster kan er een ingress definitie aan te maken. Dat kan via het tabblad Ingresses. Druk vervolgens op Create in de rechterbovenhoek en vul de volgende yaml definitie in:

```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: hello-world
    annotations:
      kubernetes.io/ingress.class: "nginx"
  spec:
    rules:
    - host: hello-world.k8s.delta10.nl
      http:
        paths:
        - path: /
          backend:
            serviceName: hello-world
            servicePort: 5000
```

In deze configuratie wordt de host `hello-world.k8s.delta10.nl` gekoppeld aan de service `hello-world` op poort `5000`. Pas de host aan voor jouw omgeving en controleer of de DNS verwijst naar de Ingress controller van het cluster. Druk vervolgens op "Upload".

Nu de ingress definitie is aangemaakt kan de applicatie ook van buiten benaderd worden via de ingress controller. Ga met je webbrowser naar [http://{ingestelde-host}](http://{ingestelde-host}) om het resultaat te bekijken.

![Een schermafbeelding van de hello world applicatie in de webbrowser](/kubernetes/images/in-browser.png)

#### De applicatie opschalen
Om de applicatie op te schalen ga je terug naar het tabblad Deployments. Klik vervolgens op de hello-world deployment en kies vervolgens in de rechterbovenhoek voor de optie Edit.

![Een schermafbeelding van het Edit a deployment scherm](/kubernetes/images/edit-deployment.png)

Vervolgens kun je het getal `1` bij replicas verhogen naar `4`. Druk op Update om de wijziging door te voeren. Ga naar pods om te kijken of er `4` replicas actief zijn.

![Een schermafbeelding van het de verschillende pods](/kubernetes/images/multiple-pods.png)

Het verkeer vanuit de ingress en de service wordt nu automatisch verdeeld over de vier beschikbare pods.

#### De versie van een applicatie vernieuwen
Het vernieuwen van de versie van een applicatie gaat op een soortgelijke manier door de deployment aan te passen. Nu passen we alleen onder de container spec de image aan van `bartj/hello-world:1.0.0` naar `bartj/hello-world:2.0.0`.

![Een schermafbeelding van het Edit a deployment scherm, het onderdeel image](/kubernetes/images/edit-deployment-image.png)

Druk op Update om de aanpassing te bevestigen. Kubernetes vernieuwd de applicatie standaard via de [Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/) strategie waarbij de pods stapsgewijs vernieuwd worden zodat het productieverkeer niet verstoord wordt.

#### De applicatie verwijderen
Het verwijderen van een applicatie gaat op een soortgelijke manier. Ga naar Deployments en kies voor de hello-world applicatie. Druk vervolgens op het knopje Delete rechtsboven om de applicatie te verwijderen. Bevestig de actie. De deployment wordt nu verwijderd. Vergeet niet om daarna ook de service en eventueel de ingress definitie te verwijderen.
---
title: "Kubernetes"
description: ""
weight: 20
menu:
  docs:
---

Kubernetes vereenvoudigt het ontwikkelen, uitrollen en onderhouden van schaalbare gedistribueerde applicaties enorm. Het systeem helpt organisaties om de betrouwbaarheid van applicaties te vergroten, maakt het zeer eenvoudig om nieuwe versies van de applicatie uit te rollen en vereenvoudigt de samenwerking tussen beheerders en ontwikkelaars. De grootste voordelen van Kubernetes zijn snelheid, betrouwbaarheid en doeltreffendheid (efficiency). Kubernetes is open source en heeft in de loop der tijd een enorme community aan zich weten te binden. Het is ontstaan vanuit Google, dat het project inmiddels heeft gedoneerd aan de onafhankelijke  <a href="https://www.cncf.io/" target="_blank">Cloud Native Computing Foundation (CNCF)</a>.

### Gedistribueerde systemen
Diensten worden steeds vaker geleverd via gedistribueerde systemen. Een gedistribueerd systeem bestaat uit meerdere kleinere programma’s die op verschillende servers draaien en gelijktijdig uitgevoerd worden. Deze kleinere programma’s communiceren met elkaar via API’s, die altijd beschikbaar moeten zijn zodat het gehele systeem altijd blijft functioneren. Er worden dus hoge eisen gesteld aan de betrouwbaarheid van gedistribueerde systemen. Onderhoud, software-updates en het opschalen van het systeem mogen de beschikbaar niet aantasten.
Kubernetes zorgt ervoor dat veranderingen aan gedistribueerde systemen snel kunnen worden doorgevoerd terwijl de dienst beschikbaar is. Dit is van essentieel belang, omdat vrijwel alle diensten tegenwoordig meerdere keren per dag worden aangepast. Kubernetes is gebaseerd op een aantal vernieuwende concepten:

- Onveranderlijke infrastructuur (immutable infrastructure);
- Declaratieve configuratie;
- Zelfhelende systemen.

### Mutable vs. immutable infrastructuur
Traditioneel werden veranderingen in softwaresystemen doorgevoerd door updates bovenop een bestaand systeem te plaatsen, waardoor op den duur een opeenstapeling van updates ontstond en het systeem steeds complexer werd. Met deze methode werd dus steeds een nieuwe wijziging aan hetzelfde systeem toegevoegd, vandaar de term mutable (veranderlijke) infrastructuur. 

Bij immutable (onveranderlijke) systemen daarentegen wordt voor elke wijziging een nieuwe image (versie) gebouwd die de gehele oude versie vervangt. Dit heeft een ingrijpende vereenvoudiging van systemen als gevolg. Door de precieze documentatie kunnen eventuele fouten snel getraceerd worden, eventueel na vergelijking met de oude versie. Ook kan in noodgevallen de oude versie opnieuw in werking worden gesteld, wat vroeger vrijwel onmogelijk was.

In Kubernetes worden in principe geen wijzigingen aangebracht aan werkzame containers. Alleen in noodgevallen wordt dit toch gedaan, waarna deze gewijzigde containers zo snel mogelijk alsnog worden vervangen door geheel nieuwe versies. 

Declaratieve configuratie en zelfhelende systemen
Declaratieve configuratie is een nieuwe manier van aansturen van een systeem. Van oudsher wordt software aangestuurd door middel van imperatieve configuratie, waarbij het systeem een serie van commando’s nauwgezet uitvoert. Bij declaratieve configuratie wordt echter alleen de gewenste staat van het systeem gecommuniceerd. De software moet deze gewenste (‘declaratieve’) staat realiseren en handhaven zonder instructies te krijgen over hoe dit moet gebeuren. Deze laatste methode is niet alleen veel minder foutgevoelig, maar opent ook nieuwe mogelijkheden om code te controleren en te testen. 

Stel dat je drie kopieën van een applicatie wilt. Bij imperatieve configuratie zou het commando ongeveer als volgt luiden: ‘Start A, start B, start C’. Bij declaratieve configuratie zou het commando de volgende strekking hebben: ‘kopieën is gelijk aan drie’. Kubernetes zal dan voortdurend controleren of er drie replica’s zijn en dit aantal herstellen wanneer er handmatig een replica wordt toegevoegd of verwijderd. Dit wordt zelfhelend vermogen genoemd. Zelfhelende systemen verminderen de werklast van systeembeheerders, waardoor er meer tijd overblijft voor het ontwikkelen en testen van nieuwe features.


### Opschalen en uitbreiden
Kubernetes kan bijdragen aan zowel het opschalen van diensten als het uitbreiden van de bijbehorende teams van ontwikkelaars. Dit komt vooral vanwege de ontkoppelde architectuur van Kubernetes. Ook maakt Kubernetes het invoeren van een microservice architectuur veel eenvoudiger. 

### Microservice architectuur
Microservice architectuur houdt in dat een mega-applicatie is opgesplitst in vele mini-applicaties, die van elkaar gescheiden zijn maar wel een gezamenlijke infrastructuur gebruiken. Alle mini-applicaties hebben in principe een eigen ontwikkelteam. Voor elke nieuwe feature kan eenvoudig een nieuwe microservice met een nieuw ontwikkelteam worden ingesteld, waardoor opschalen relatief eenvoudig is. 

De onderliggende infrastructuur is zeer complex en verzekert onder meer dat microservices met elkaar kunnen samenwerken. Kubernetes biedt vele tools en API’s om een microservice architectuur te bouwen:
Pods, groepen van een of meerdere containers, kunnen gezamenlijk specifieke taken uitvoeren;
Load balancing, naming en discovery kunnen gebruikt worden om microservices van elkaar te scheiden; Door het gebruik van load balancers kan de capaciteit van een programma eenvoudig worden opgeschaald zonder dat dit effect heeft op andere lagen van de dienst. 
Met behulp van namespaces kan elke microservice bepalen in hoeverre het met andere microservices wil samenwerken;
Ingress objects bieden een frontend waarmee meerdere microservices eenvoudig gezamenlijk extern kunnen communiceren.

### Applicaties en clusters opschalen
Met Kubernetes komt het opschalen van een applicatie neer op het aanpassen van een getal in de declaratieve staat, wat overigens ook geautomatiseerd kan gebeuren. Ook het opschalen van een geheel cluster is eenvoudig met Kubernetes. Cluster kunnen gemakkelijk worden uitgebreid met nieuwe machines, aangezien alle machines identiek aan elkaar zijn. Door het gebruik van containers zijn applicaties namelijk losgekoppeld van specifieke servers. Dit maakt ook voorspellingen over toekomstige groei en benodigde opschaling een stuk accurater. Voortaan hoeft namelijk niet langer per machine een schatting van de toekomstige groei te worden gemaakt, maar is één globale schatting van de gemiddelde groei van het totale aantal applicaties voldoende. Dit leidt tot betere voorspellingen. 

### Efficiënter gebruik van servercapaciteit
Het loskoppelen van applicaties en specifieke machines heeft als bijkomend voordeel dat servers door meerdere teams tegelijkertijd kunnen worden gebruikt. Hierdoor kunnen servers efficiënter worden benut, wat de overhead (verder) verkleint. Ook biedt Kubernetes tools om applicaties automatisch over een cluster van servers te verdelen, wat de benutting van servers nog verder verbetert.  

Kubernetes leidt ook tot sneller en goedkoper testen. Testomgevingen kunnen eenvoudig worden aangemaakt als een set containers die gebruik maakt van een Kubernetes cluster, waarbij alle ontwikkelaars hetzelfde testcluster kunnen gebruiken. Hierdoor zijn er minder servers nodig om te testen en worden de servers efficiënter gebruikt.












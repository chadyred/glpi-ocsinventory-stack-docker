# GLPI with OCS inventory

[![Build Status](https://travis-ci.com/chadyred/glpi-ocsinventory-stack-docker.svg?branch=changelog)](https://travis-ci.com/chadyred/glpi-ocsinventory-stack-docker)

## TL;DR

#### First: install with make

Make is install so only do a : 

`make install`

#### Second: environment

On `environment/env.mk` set your `TZ` and `TIMEZONE` value.

#### Reinstallation

Whole reinstall ( **/!\ ALL WILL BE REMOVES /!\\** ) and you have to do reset your env value (Second step):

`make reinstall`

#### Help

`make help`

TIPS:
 - Only do a `make` to see allowed task and you see :

```
.env           Configure environment variable available for docker-compose
hard-restart   Restart project AND REMOVE ALL VOLUME (except glpi app installation)
hard-stop      Stop project AND REMOVE ALL VOLUME (except glpi app installation)
install        Install project
reinstall      Stop and remove all and reinstall all
restart        Restart project
start          Start project
stop           Stop project

```

#### Details about installation

It will start up all the environment:

1. OCS stack on port `8080`
2. GLPI project + DB & config on port `80`

#### GLPI

Go to `http://localhost` with the default credentials:

login - glpi

pass - glpi 

#### OCS Inventory Server

Go to `http://localhost:8080` with the default credentials:

login - admin

pass - admin

##### URI 

On OCS inventory URL are `/ocsreports`, `/download` and `/snmp`, and for all client agent, configuration have to send infor;ation to URI `/ocsinventory` for send informations.

>> 400 error (Bad Request) on the uri `/ocsinventory` and 400 forbidden on `/download` on browser **is normal** : this url is for agent install on all your devices which are clients and send information about their devices.

#### About OCS Inventoy and many infomation

-----

<p align="center">
  <img src="https://cdn.ocsinventory-ng.org/common/banners/banner660px.png" height=300 width=660 alt="Banner">
</p>

<h1 align="center">OCS Inventory</h1>
<p align="center">
  <b>Some Links:</b><br>
  <a href="http://ask.ocsinventory-ng.org">Ask question</a> |
  <a href="https://www.ocsinventory-ng.org/?utm_source=github-ocs">Website</a> |
  <a href="https://www.ocsinventory-ng.org/en/#ocs-pro-en">OCS Professional</a>
</p>

<p align='justify'>
OCS (Open Computers and Software Inventory Next Generation) is an assets management and deployment solution.
Since 2001, OCS Inventory NG has been looking for making software and hardware more powerful.
OCS Inventory NG asks its agents to know the software and hardware composition of every computer or server.
</p>




<h2 align="center">Assets management</h2>
<p align='justify'>
Since 2001, OCS Inventory NG has been looking for making software and hardware more powerful. OCS Inventory NG asks its agents to know the software and hardware composition of every computer or server. OCS Inventory also ask to discover network’s elements which can’t receive an agent. Since the version 2.0, OCS Inventory NG take in charge the SNMP scans functionality.
This functionality’s main goal is to complete the data retrieved from the IP Discover scan. These SNMP scans will allow you to add a lot more informations from your network devices : printers, scanner, routers, computer without agents, …
</p>

<h2 align="center">Deployment</h2>
<p align='justify'>
OCS Inventory NG includes the packet deployment functionality to be sure that all of the softwares environments which are on the network are the same. From the central management server, you can send the packets which will be downloaded with HTTP/HTTPS and launched by the agent on client’s computer. The OCS deployment is configured to make the packets less impactable on the network. OCS is used as a deployment tool on IT stock of more 100 000 devices.
</p>
<br />

###Docker Stack OCSInventory

This repository contains the needed files to build and run the OCS stack in his last version.
This stack is based on the official [Debian image](https://hub.docker.com/_/debian/) and official [MYSQL image](https://hub.docker.com/_/mysql/), you can find them on the [Docker hub](https://hub.docker.com/explore/).
We include a MYSQL container with pre-configured with the required database settings.

By default, when the OCSInventory container is running it will load a default OCSInventory installation that is ready to be used. However, you can run the installer by defining one of these env variables, you can find them in the docker-compose.YML

####MYSQL container :

environment:
```
MYSQL_ROOT_PASSWORD : changeme 
MYSQL_USER : ocs 
MYSQL_PASSWORD : ocs 
MYSQL_DATABASE : ocs 
```
----------

####OCSInventory-server container :

environment :
```
OCS_DBNAME : ocs
OCS_DBSERVER_READ : db-ocs
OCS_DBSERVER_WRITE : db-ocs
OCS_DBUSER : ocs
OCS_DBPASS : ocs
```
These values are the default values for OCSInventory.
After adjusting the docker-compose.yml, you can test the containers with docker-compose

```
cd OCSInventory-Docker-Stack
sudo docker-compose build
sudo docker-compose up
```

This will bring up all needed containers, link them and mount data volumes according to the docker-compose.yml configuration file.

###Container shell access and viewing container logs

The docker exec command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your OCSInventory container:

```sudo docker exec -it ocsinventory-server bash```

or

```sudo docker exec -it ocsinventory-db bash```

You can access the logs from the container OCSInventory through Docker container log:

```sudo docker logs ocsinventory-server```

or

> sudo docker logs ocsinventory-db

###Data Volume

Two volumes are created at the start of the stack OCSInventory. They contain the necessary information to ensure a proper functioning of OCS Inventory as well as MYSQL

By default:

**ocsdata** for the MYSQL service
   - /var/lib/mysql/

**glpidata** for the MYSQL service
   - /var/lib/mysql/

**ocssrv** for service OCSInventory 
   - /usr/share/ocsinventory-reports/
   - /etc/ocsinventory-reports/
   - /var/lib/ocsinventory-reports/


Attention do not remove these volumes without having planned backup, otherwise you will lose your data.

<h2 align="center">GLPI integration</h2>
<p align='justify'>
GLPI stands for Gestionnaire Libre de Parc Informatique is a Free Asset and IT Management Software package, that provides ITIL Service Desk features, licenses tracking and software auditing. http://glpi-project.org/
<br />
GitHub - https://github.com/glpi-project/glpi
</p>


----------

## Contributing

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Add your changes: git add folder/file1.php
4. Commit your changes: git commit -m 'Add some feature'
5. Push to the branch: git push origin my-new-feature
6. Submit a pull request !

## License

OCS Inventory Docker Stack is GPLv3 licensed

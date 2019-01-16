# docker sabnzbd by StudioEtrange

* Run sabnzbd inside a docker container built upon debian
* Based on sabnzbd github repository
* Choice of sabnzbd version
* Use supervisor to manage sabnzbd process
* Can choose a specific unix user to run sabnzbd inside docker
* By default sabnzbd configuration files will be in a folder named 'sabnzbd' which will be contained in a docker volume /data
* Optional volume 'download' used as download folder
* Embedded multi core version of par2 https://sabnzbd.org/wiki/installation/multicore-par2

## Quick Usage

for running latest stable version of sabnzbd :
	
	mkdir -p data
	docker run --name sabnzbd -d -h $(hostname) -v $(pwd)/data:/data -p 8080:8080 studioetrange/docker-sabnzbd

then go to http://hostname:8080

## Docker tags

Available tag for studioetrange/docker-sabnzbd:__TAG__

	latest, 2.3.6Beta1, 2.3.5, 2.3.5RC2, 2.3.5RC1, 2.3.4, 2.3.4RC1, 2.3.3, 2.3.3RC2, 2.3.3RC1, 2.3.3Beta1, 2.3.2, 2.3.2RC2, 2.3.2RC1, 2.3.1, 2.3.1RC2, 2.3.1RC1, 2.3.1Beta1, 2.3.0, 2.3.0RC2, 2.3.0RC1, 2.3.0Alpha2, 2.3.0Alpha1, 2.2.1, 2.2.1RC2, 2.2.1RC1, 2.2.0, 2.2.0RC3, 2.2.0RC2, 2.2.0RC1, 2.2.0Beta2, 2.2.0Beta1, 2.2.0Alpha3, 2.2.0Alpha2, 2.2.0Alpha1, 2.1.0, 2.1.0RC1, 2.1.0Beta1, 2.0.1, 2.0.1RC2, 2.0.1RC1, 2.0.0, 2.0.0RC3, 2.0.0RC2, 2.0.0RC1, 2.0.0Beta1, 2.0.0Alpha1, 1.2.3, 1.2.2, 1.2.1, 1.2.1RC1, 1.2.1Beta1, 1.2.0, 1.2.0RC1, 1.2.0Beta1, 1.1.1, 1.1.1RC3, 1.1.1RC2, 1.1.1RC1, 1.1.0, 1.1.0RC4, 1.1.0RC3, 1.1.0RC2, 1.1.0RC1, 1.1.0Beta1, 1.0.3, 1.0.2, 1.0.1, 1.0.1RC1, 1.0.0, 1.0.0RC5, 1.0.0RC4, 1.0.0RC3, 1.0.0RC2, 1.0.0RC1, 0.8.0Beta6, 0.8.0Beta5, 0.8.0Beta4, 0.8.0Beta3, 0.8.0Beta2, 0.8.0Beta1, 0.8.0Alpha2, 0.8.0Alpha1, 0.7.20, 0.7.20RC2, 0.7.20RC1, 0.7.19, 0.7.19RC4, 0.7.19RC3, 0.7.19RC2, 0.7.19RC1, 0.7.18, 0.7.18RC1, 0.7.17, 0.7.17RC2, 0.7.17RC1, 0.7.17Beta3, 0.7.17Beta2, 0.7.17Beta1, 0.7.16, 0.7.15, 0.7.14, 0.7.13, 0.7.12, 0.7.11, 0.7.11RC2, 0.7.11RC1, 0.7.10, 0.7.10RC1, 0.7.9, 0.7.9RC1, 0.7.8, 0.7.8RC1, 0.7.7, 0.7.6, 0.7.6Final, 0.7.6Beta2, 0.7.6Beta1, 0.7.5, 0.7.5RC1, 0.7.4, 0.7.4RC2, 0.7.4RC1, 0.7.4Beta3, 0.7.4Beta2, 0.7.4Beta1, 0.7.3, 0.7.3RC1, 0.7.3Beta2, 0.7.3Beta1, 0.7.2, 0.7.2RC2, 0.7.2RC1, 0.7.1, 0.7.1RC5, 0.7.1RC4, 0.7.1RC3, 0.7.1RC2, 0.7.1RC1, 0.7.0, 0.7.0RC2, 0.7.0RC1, 0.7.0Beta8, 0.7.0Beta7, 0.7.0Beta6, 0.7.0Beta6u, 0.7.0Beta5, 0.7.0Beta4, 0.7.0Beta3, 0.7.0Beta2, 0.7.0Beta1, 0.7.0Alpha3, 0.7.0Alpha2, 0.7.0Alpha1, 0.6.15, 0.6.15RC1, 0.6.14, 0.6.12, 0.6.11, 0.6.11RC1, 0.6.10, 0.6.10RC1, 0.6.9, 0.6.9RC2, 0.6.9RC1, 0.6.8, 0.6.8RC1, 0.6.7, 0.6.6, 0.6.5, 0.6.4, 0.6.3, 0.6.2, 0.6.1, 0.6.0

Current latest tag is version __2.3.6Beta1__

## Instruction

### Build from github source

	git pull https://github.com/StudioEtrange/docker-sabnzbd
	cd docker-sabnzbd
	docker build -t=studioetrange/docker-sabnzbd .

### Retrieve image from docker registry

	docker pull studioetrange/docker-sabnzbd

### Standard usage

	mkdir -p download
	mkdir -p data
	docker run --name sabnzbd -h $(hostname) -d -v $(pwd)/data:/data -v $(pwd)/download:/download -p 8080:8080 -p 8081:8081 -e SERVICE_USER=$(id -u):$(id -g) -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro studioetrange/docker-sabnzbd

sabnzbd needs to know fully qualified domain name (FQDN) used to access it. And these authorized valued are in config file at `whitelist` value, which is populated by defaut whih container `hostname`

### Full run parameters

	docker run --name sabnzbd -h $(hostname) -d -v <data path>:/data -v <download path>:/download -p <sabnzbd http port>:8080 -p <sabnzbd https port>:8081 -e SERVICE_USER=<uid[:gid]>  -p <supervisor manager http port>:9999 -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro studioetrange/docker-sabnzbd:<version>

### Volumes

Inside container
`/data/sabnzbd` will contain sabnzbd tautulli and files
`/download` is the root folder of your downloaded files. It contains `/complete` `/incomplete` for complete/incomplete files and `/vault` for watched nzb files to download

If any path of theses volumes do not exist on the host while your are mounting them inside container, docker will create it automaticly with root user. You should use mkdir before launching docker to control ownership.


### Access to a running instance

supervisorctl access

	docker exec -it sabnzbd bash -c ". activate sabnzbd && supervisorctl"
	
bash access

	docker exec -it sabnzbd bash -c ". activate sabnzbd"
 

### Test a shell inside a new container without sabnzbd running

	docker run -it --rm studioetrange/docker-sabnzbd bash

### Stop and destroy all previously launched services

	docker stop sabnzbd && docker rm sabnzbd

## Access point

### sabnzbd

	Go to http://hostname:SABNZBD_HTTP_PORT/ and https://hostname:SABNZBD_HTTPS_PORT

### Supervisor process manager

	Go to http://hostname:SUPERVISOR_HTTP_WEB/

## Notes on Github / Docker Hub Repository

* This github repository is linked to an automated build in docker hub registry.

	https://registry.hub.docker.com/u/studioetrange/docker-sabnzbd/

* _update.sh_ is only an admin script for this project which update and add new versions. This script do not auto create missing tag in docker hub webui. It is only for this project admin/owner purpose.

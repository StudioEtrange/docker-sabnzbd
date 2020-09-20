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

Pre-setted buildable docker tags for studioetrange/docker-sabnzbd:__TAG__

	latest, 3.1.0RC1, 3.1.0Beta2, 3.1.0Beta1, 3.0.2, 3.0.2RC2, 3.0.2RC1, 3.0.1, 3.0.1RC1, 3.0.0, 3.0.0RC2, 3.0.0RC1, 3.0.0Beta4, 3.0.0Beta3, 3.0.0Beta2, 3.0.0Beta1, 3.0.0Alpha2, 3.0.0Alpha1, 2.3.9

Current latest tag is version __3.1.0RC1__

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

sabnzbd needs to know fully qualified domain name (FQDN) used to access it. And these authorized valued are in config file at `whitelist` value, which is populated by defaut whih container `hostname`. You can add other domain name with the env var `HOST_WHITELIST_ENTRIES`


### Full run parameters

	docker run --name sabnzbd -h $(hostname) -e HOST_WHITELIST_ENTRIES="sabnzbd.mydomain.org, sabnzbd.alt.com" -d -v <data path>:/data -v <download path>:/download -p <sabnzbd http port>:8080 -p <sabnzbd https port>:8081 -e SERVICE_USER=<uid[:gid]> -p <supervisor manager http port>:9999 -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro studioetrange/docker-sabnzbd:<version>

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

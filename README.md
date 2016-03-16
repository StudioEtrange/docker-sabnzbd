# docker sabnzbd by StudioEtrange *broken for now*

* Run sabnzbd inside a docker container built upon debian
* Based on sabnzbd github source code
* Choice of sabnzbd version
* Install a concurrent (multithreaded) version of par2 from chuchusoft.com *TODO : migrate to https://github.com/Parchive/par2cmdline ?*
* Use supervisor to manage sabnzbd process
* By default sabnzbd configuration and download files will be in /data/sabnzbd _(You should map a docker volume to /data)_


## Sample Usage

to run latest sabnzbd version :

	docker run -d -v $(pwd):/data -p 8080:8080 studioetrange/docker-sabnzbd:latest

then go to http://localhost:8080

## Docker tags

Available tag for studioetrange/docker-couchpotato:__TAG__

	latest, 0.8.0Beta6, 0.8.0Beta5, 0.8.0Beta4, 0.8.0Beta3, 0.8.0Beta2, 0.8.0Beta1, 0.8.0Alpha2, 0.8.0Alpha1, 0.7.20, 0.7.20RC2, 0.7.20RC1, 0.7.19, 0.7.19RC4, 0.7.19RC3, 0.7.19RC2, 0.7.19RC1, 0.7.18, 0.7.18RC1, 0.7.17, 0.7.17RC2, 0.7.17RC1, 0.7.17Beta3, 0.7.17Beta2, 0.7.17Beta1, 0.7.16, 0.7.15, 0.7.14, 0.7.13, 0.7.12, 0.7.11, 0.7.11RC2, 0.7.11RC1, 0.7.10, 0.7.10RC1, 0.7.9, 0.7.9RC1, 0.7.8, 0.7.8RC1, 0.7.7, 0.7.6, 0.7.6Final, 0.7.6Beta2, 0.7.6Beta1, 0.7.5, 0.7.5RC1, 0.7.4, 0.7.4RC2, 0.7.4RC1, 0.7.4Beta3, 0.7.4Beta2, 0.7.4Beta1, 0.7.3, 0.7.3RC1, 0.7.3Beta2, 0.7.3Beta1, 0.7.2, 0.7.2RC2, 0.7.2RC1, 0.7.1, 0.7.1RC5, 0.7.1RC4, 0.7.1RC3, 0.7.1RC2, 0.7.1RC1, 0.7.0, 0.7.0RC2, 0.7.0RC1, 0.7.0Beta8, 0.7.0Beta7, 0.7.0Beta6, 0.7.0Beta6u, 0.7.0Beta5, 0.7.0Beta4, 0.7.0Beta3, 0.7.0Beta2, 0.7.0Beta1, 0.7.0Alpha3, 0.7.0Alpha2, 0.7.0Alpha1, 0.6.15, 0.6.15RC1, 0.6.14, 0.6.12, 0.6.11, 0.6.11RC1, 0.6.10, 0.6.10RC1, 0.6.9, 0.6.9RC2, 0.6.9RC1, 0.6.8, 0.6.8RC1, 0.6.7, 0.6.6, 0.6.5, 0.6.4, 0.6.3, 0.6.2, 0.6.1, 0.6.0

Current latest tag is version __0.8.0Beta6__

## Instruction 

### build from github source

	git pull https://github.com/StudioEtrange/docker-sabnzbd
	cd docker-sabnzbd
	docker build -t=studioetrange/docker-sabnzbd .

### retrieve image from docker registry

	docker pull studioetrange/docker-sabnzbd

### run sabnzbd 

	docker run -v DATA_DIR:/data -p SABNZBD_HTTP_PORT:8080 -p SABNZBD_HTTPS_PORT:8081 -p SUPERVISOR_HTTP_WEB:9999 studioetrange/docker-sabnzbd:SABNZBD_VERSION

### run sabnzbd daemonized

	docker run -d -v DATA_DIR:/data -p SABNZBD_HTTP_PORT:8080 -p SABNZBD_HTTPS_PORT:8081 -p SUPERVISOR_HTTP_WEB:9999 studioetrange/docker-sabnzbd:SABNZBD_VERSION


### run a shell inside this container (without sabnzdbd running)

	docker run -i -t studioetrange/docker-sabnzbd bash

## Access point

### Sabnzbd

	http://localhost:SABNZBD_HTTP_PORT/

### Supervisor

	http://localhost:SUPERVISOR_HTTP_WEB/


## Notes on Github / Docker Hub Repository

* This github repository is linked to an automated build in docker hub registry.

	https://hub.docker.com/r/studioetrange/docker-sabnzbd/

* _update.sh_ is only an admin script which update and add new versions. This script do not auto create missing tag in docker hub webui. It is only for admin/owner purpose.

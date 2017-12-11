# docker sabnzbd by StudioEtrange

* Run sabnzbd inside a docker container built upon debian
* Based on sabnzbd github source code
* Choice of sabnzbd version
* Install a concurrent (multithreaded) version of par2
* Use supervisor to manage sabnzbd process
* By default sabnzbd configuration and download files will be in /data/sabnzbd _(You should map a docker volume to /data)_


## Sample Usage

to run latest sabnzbd version :

	docker run -d -v $(pwd):/data -p 8080:8080 studioetrange/docker-sabnzbd:latest

then go to http://localhost:8080

## Docker tags

Available tag for studioetrange/docker-couchpotato:__TAG__

	latest, 2.3.2RC2, 2.3.2RC1, 2.3.1, 2.3.1RC2, 2.3.1RC1, 2.3.1Beta1, 2.3.0, 2.3.0RC2, 2.3.0RC1, 2.3.0Alpha2, 2.3.0Alpha1, 2.2.1, 2.2.1RC2, 2.2.1RC1, 2.2.0, 2.2.0RC3, 2.2.0RC2, 2.2.0RC1, 2.2.0Beta2, 2.2.0Beta1, 2.2.0Alpha3, 2.2.0Alpha2, 2.2.0Alpha1, 2.1.0, 2.1.0RC1, 2.1.0Beta1, 2.0.1, 2.0.1RC2, 2.0.1RC1, 2.0.0, 2.0.0RC3, 2.0.0RC2, 2.0.0RC1, 2.0.0Beta1, 2.0.0Alpha1, 1.2.3, 1.2.2, 1.2.1, 1.2.1RC1, 1.2.1Beta1, 1.2.0, 1.2.0RC1, 1.2.0Beta1, 1.1.1, 1.1.1RC3, 1.1.1RC2, 1.1.1RC1, 1.1.0, 1.1.0RC4, 1.1.0RC3, 1.1.0RC2, 1.1.0RC1, 1.1.0Beta1, 1.0.3, 1.0.2, 1.0.1, 1.0.1RC1, 1.0.0, 1.0.0RC5, 1.0.0RC4, 1.0.0RC3, 1.0.0RC2, 1.0.0RC1, 0.8.0Beta6, 0.8.0Beta5, 0.8.0Beta4, 0.8.0Beta3, 0.8.0Beta2, 0.8.0Beta1, 0.8.0Alpha2, 0.8.0Alpha1, 0.7.20, 0.7.20RC2, 0.7.20RC1, 0.7.19, 0.7.19RC4, 0.7.19RC3, 0.7.19RC2, 0.7.19RC1, 0.7.18, 0.7.18RC1, 0.7.17, 0.7.17RC2, 0.7.17RC1, 0.7.17Beta3, 0.7.17Beta2, 0.7.17Beta1, 0.7.16, 0.7.15, 0.7.14

Current latest tag is version __2.3.2RC2__

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

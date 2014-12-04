# docker sabnzbd by StudioEtrange

* Run sabnzbd inside a docker container built upon debian
* Based on sabnzbd github source code
* Choice of sabnzbd version
* Install a concurrent (multithreaded) version of par2 from chuchusoft.com
* Use supervisor to manage sabnzbd process
* By default sabnzbd configuration and download files will be in /data/sabnzbd


## Sample Usage

for running sabnzbd version 0.7.20 :

	docker run -d -v $(pwd):/data -p 8080:8080 studioetrange/docker-sabnzbd:0.7.20

then go to http://localhost:8080

## Version and Tag

* Each tag is a different version of Sabnzbd
* latest is the latest stable sabznbd version available through this repository
* 0.7.x is the development version from sabnzbd git repository. But you should build the image yourself OR use /opt/sabnzbd-update.sh to have an uptodate image.

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

	docker run -i -t studioetrange/docker-sabnzbd

## Access point

### Sabnzbd

	Go to http://localhost:SABNZBD_HTTP_PORT/
	and configure sabnzbd

### Supervisor

	Go to http://localhost:SUPERVISOR_HTTP_WEB/

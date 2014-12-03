# docker sabnzbd by StudioEtrange

* Run sabnzbd in a ubuntu docker container
* Based on sabnzbd github source code - Each tag is a different version of Sabnzbd
* Install a concurrent (multithreaded) version of par2 from chuchusoft.com
* Use supervisor to manage sabnzbd process
* By default sabnzbd configuration and download files will be in /data/sabnzbd


**_Please choose a version of sabnzbd, by default this is 'latest' which is the unstable branch of sabnzbd git repository_**

## Sample Usage

	docker run -d -v .:/data -p 8080:8080 studioetrange/docker-sabnzbd:0.7.19

then go to http://localhost:8080

## Instruction 

### build from github source

	git pull https://github.com/StudioEtrange/docker-sabnzbd
	cd docker-sabnzbd
	docker build -t=studioetrange/docker-sabnzbd .

### build from docker registry

	docker pull studioetrange/docker-sabnzbd
	docker build -t=studioetrange/docker-sabnzbd .

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

## Supervisor

	Go to http://localhost:SUPERVISOR_HTTP_WEB/
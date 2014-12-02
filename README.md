# docker sabnzbd

## build from github source
git pull https://github.com/StudioEtrange/docker-sabnzbd
cd docker-sabnzbd
docker build -t=studioetrange/docker-sabnzbd .

## build from docker registry
docker pull studioetrange/docker-sabnzbd
docker build -t=studioetrange/docker-sabnzbd .

## run sabnzbd 
docker run -v DATA_DIR:/data -p SABNZBD_HTTP_PORT:8080 -p SABNZBD_HTTPS_PORT:8081 -p SUPERVISOR_HTTP_WEB:9999 studioetrange/docker-sabnzbd

## run sabnzbd daemonized
docker run -d -v DATA_DIR:/data -p SABNZBD_HTTP_PORT:8080 -p SABNZBD_HTTPS_PORT:8081 -p SUPERVISOR_HTTP_WEB:9999 studioetrange/docker-sabnzbd

## Note 
By default all sabnzbd configuration and download files will be in /data/sabnzbd


## run a shell in container (without sabnzdbd running)
docker run -i -t studioetrange/docker-sabnzbd

## Open sabnzbd
Go to http://localhost:SABNZBD_HTTP_PORT/

## Supervisor
Go to http://localhost:SUPERVISOR_HTTP_WEB/
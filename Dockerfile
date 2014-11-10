FROM debian:wheezy
MAINTAINER StudioEtrange <nomorgan@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get install -y python \
						python-cheetah \
						python-configobj \
						python-feedparser \
						python-dbus \
						python-openssl \
						python-support \
						python-yenc \
						par2 \
						unrar-free \
						unzip \
	&& rm -rf /var/lib/apt/lists/*
	


ENV SABNZBD_VERSION 0.7.19

RUN apt-get update \
	&& apt-get install -y curl --no-install-recommends \
	&& mkdir /opt/sabnzbd-src \
	&& curl -k -SL "https://github.com/sabnzbd/sabnzbd/archive/$SABNZBD_VERSION.tar.gz" -o sabnzbd.tar.gz \
	&& apt-get purge -y --auto-remove curl \
	&& tar -xzf sabnzbd.tar.gz -C /opt/sabnzbd-src
FROM debian:wheezy
MAINTAINER StudioEtrange <nomorgan@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list \
	&& echo "deb http://http.debian.net/debian wheezy-updates non-free" >> /etc/apt/sources.list

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
						unrar \
						unzip \
	&& rm -rf /var/lib/apt/lists/*
	


ENV SABNZBD_VERSION 0.7.19

RUN apt-get update \
	&& apt-get install -y curl --no-install-recommends \
	&& mkdir -p /opt/sabnzbd \
	&& curl -k -SL "https://github.com/sabnzbd/sabnzbd/archive/$SABNZBD_VERSION.tar.gz" -o /opt/sabnzbd.tar.gz \
	&& tar -xzf /opt/sabnzbd.tar.gz -C /opt/sabnzbd --strip-components=1 \
	&& apt-get purge -y --auto-remove curl \
	&& rm -Rf /opt/sabnzbd.tar.gz \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /config && mkdir -p /data

WORKDIR /opt/sabnzbd
RUN python tools/make_mo.py

VOLUME /config
VOLUME /data


EXPOSE 8080


CMD ["./SABnzbd.py", "--daemon", "--config-file /config", "--server :8080"]
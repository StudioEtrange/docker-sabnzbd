FROM debian:wheezy
MAINTAINER StudioEtrange <nomorgan@gmail.com>

ENV SABNZBD_VERSION 0.7.19

# Debian package & stuff -------------

# Fix a Debianism of the nobody's uid being 65534
#RUN usermod -u 99 nobody
#RUN usermod -g 100 nobody

RUN echo "deb http://http.debian.net/debian wheezy non-free" >> /etc/apt/sources.list \
	&& echo "deb http://http.debian.net/debian wheezy-updates non-free" >> /etc/apt/sources.list

# DEBIAN packages
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
						supervisor \
						unrar \
						unzip \
						curl \
	&& rm -rf /var/lib/apt/lists/*

# DEBIAN packages : SABNZBD dependencies install ----------
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
						python \
						python-cheetah \
						python-configobj \
						python-feedparser \
						python-dbus \
						python-openssl \
						python-support \
						python-yenc \
	&& rm -rf /var/lib/apt/lists/*
	

# SABNZBD install -------------

RUN mkdir -p /opt/sabnzbd && mkdir -p /config && mkdir -p /data

RUN curl -k -SL "https://github.com/sabnzbd/sabnzbd/archive/$SABNZBD_VERSION.tar.gz" \
	| tar -xzf - -C /opt/sabnzbd --strip-components=1

RUN curl -SL "http://www.chuchusoft.com/par2_tbb/par2cmdline-0.4-tbb-20100203-lin64.tar.gz" \
	| tar -xzf - -C /usr/local/bin --strip-components=1

RUN mkdir -p /config && mkdir -p /data

WORKDIR /opt/sabnzbd

RUN python tools/make_mo.py

# add ffmpeg ? : https://github.com/needo37/sabnzbd/blob/master/Dockerfile

# PURGE -------------

RUN apt-get purge -y --auto-remove curl \
	&& rm -rf /var/lib/apt/lists/*

# SUPERVISOR -------------
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisord-sabnzbd.conf /etc/supervisor/conf.d/supervisord-sabnzbd.conf

# DOCKER -------------
VOLUME /data

# Supervisord web interface -------
EXPOSE 9999
# sabnzbd http port
EXPOSE 8080
# sabnzbd https port
EXPOSE 8081

# run command by default
#CMD  ["/opt/sabnzbd/SABnzbd.py", "-f /config/sabnzbd", "--browser=0", "--server=:8080", "--https=8090"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]

#CMD ["supervisord", "-n"]
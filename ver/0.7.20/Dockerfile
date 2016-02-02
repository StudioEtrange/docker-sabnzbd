FROM studioetrange/docker-debian:wheezy
MAINTAINER StudioEtrange <nomorgan@gmail.com>

# DEBIAN packages : SABNZBD dependencies install ----------
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
						python-cheetah \
						python-configobj \
						python-feedparser \
						python-dbus \
						python-openssl \
						python-support \
						python-yenc \
	&& rm -rf /var/lib/apt/lists/*
	

# SABNZBD install -------------
ENV ITEM_VERSION 0.7.20

RUN curl -SL "http://www.chuchusoft.com/par2_tbb/par2cmdline-0.4-tbb-20100203-lin64.tar.gz" \
	| tar -xzf - -C /usr/local/bin --strip-components=1

# add ffmpeg ? : https://github.com/needo37/sabnzbd/blob/master/Dockerfile

WORKDIR /opt/sabnzbd
RUN curl -k -SL "https://github.com/sabnzbd/sabnzbd/archive/$ITEM_VERSION.tar.gz" \
	| tar -xzf - -C /opt/sabnzbd --strip-components=1

RUN python tools/make_mo.py

# SUPERVISOR -------------
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
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]

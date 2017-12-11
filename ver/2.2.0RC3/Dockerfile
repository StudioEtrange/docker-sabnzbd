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
ENV ITEM_VERSION 2.2.0RC3

#RUN curl -SL "http://www.chuchusoft.com/par2_tbb/par2cmdline-0.4-tbb-20100203-lin64.tar.gz" \
#	| tar -xzf - -C /usr/local/bin --strip-components=1

# par2 Multicore
RUN mkdir /par2tbb \
	&& cd par2tbb \
	&& git clone https://github.com/jcfp/debpkg-par2tbb.git \
	&& cd debpkg-par2tbb \
	&& uscan --force-download \
	&& dpkg-buildpackage -S -us -uc -d \
	&& dpkg-source -x ../par2cmdline-tbb_*.dsc \
	&& cd par2cmd* \
	&& ./configure --prefix=/usr --includedir=${prefix}/include --mandir=${prefix}/share/man --infodir=${prefix}/share/info --sysconfdir=/etc --localstatedir=/var --disable-silent-rules --libexecdir=${prefix}/lib/x86_64-linux-gnu --libdir=${prefix}/lib/x86_64-linux-gnu \
	&& make install

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

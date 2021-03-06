FROM debian:stretch
LABEL maintener "StudioEtrange <nomorgan@gmail.com>"
LABEL description "Sabnzbd on docker"

# NOTE : https://sabnzbd.org/wiki/installation/install-off-modules#toc8
# NOTE par2 multicore : https://sabnzbd.org/wiki/installation/multicore-par2

# PARAMETERS -------------------------------------------------------

# Service generic parameters
ENV SERVICE_NAME sabnzbd
ENV SERVICE_VERSION 3.0.0Beta3
# User id which will launch the service start command (NOTE : supervisord itself is run with root)
ENV SERVICE_USER 0
ENV SERVICE_PORT 8080
ENV SERVICE_PORT_SECURED 8081
ENV SERVICE_INSTALL_DIR /opt/${SERVICE_NAME}

# Specific service parameters
# path to store service data and configuration
ENV SERVICE_DATA_PATH /data/${SERVICE_NAME}
# external paths used by service
ENV SERVICE_VOLUME_PATH ${SERVICE_DATA_PATH} /download/complete /download/incomplete /download/vault
# args used by supervisor context for running service
ENV SERVICE_EXPORT_ARG SERVICE_DATA_PATH SERVICE_PORT SERVICE_PORT_SECURED SERVICE_INSTALL_DIR

# System parameters
ENV MINICONDA_PYTHON_MAJOR_VERSION 3
# sabnzbd still needs python 2 version
ENV SERVICE_PYTHON_VERSION 2.7.17
ENV MINICONDA_VERSION 4.7.12.1
ENV CONDA_ENV ${SERVICE_NAME}
ENV PATH /opt/miniconda/bin:$PATH


# TREE FILESYSTEM --------------------------------------------------
RUN mkdir -p /etc/supervisor/conf.d && mkdir -p /var/log/supervisor && mkdir -p "${SERVICE_INSTALL_DIR}"

WORKDIR "${SERVICE_INSTALL_DIR}"



# COMPONENTS -------------------------------------------------------

# debian packages
RUN echo "deb http://httpredir.debian.org/debian stretch main non-free" >> /etc/apt/sources.list \
	&& echo "deb http://httpredir.debian.org/debian stretch-updates main non-free" >> /etc/apt/sources.list \
	&& echo "deb http://httpredir.debian.org/debian stretch-backports main non-free" >> /etc/apt/sources.list


# NOTE : sabnzbd needs unrar non free
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
					   ca-certificates curl wget openssl libssl-dev bzip2 unrar locales \
					   dirmngr gnupg2 unzip p7zip-full \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 98703123E0F52B2BE16D586EF13930B14BB9F05F \
	&& echo "deb http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/jcfp-sabaddons.list \
	&& echo "deb-src http://ppa.launchpad.net/jcfp/sab-addons/ubuntu xenial main" >> /etc/apt/sources.list.d/jcfp-sabaddons.list \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
					   par2-tbb \
	&& rm -rf /var/lib/apt/lists/*


# locales
# https://stackoverflow.com/a/38553499
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

# Python
RUN MINICONDA_FILE=Miniconda${MINICONDA_PYTHON_MAJOR_VERSION}-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    wget https://repo.continuum.io/miniconda/${MINICONDA_FILE} -O /opt/${MINICONDA_FILE} && \
    chmod +x /opt/$MINICONDA_FILE && \
    /opt/$MINICONDA_FILE -b -p /opt/miniconda && \
    rm /opt/$MINICONDA_FILE

# create dedicated environment
RUN /opt/miniconda/bin/conda create -y -n ${CONDA_ENV} python=${SERVICE_PYTHON_VERSION}

# install supervisor
RUN bash -c "source activate ${CONDA_ENV} && \
                pip install supervisor==3.3.4"

# SERVICE INSTALL -------------------------------------------------------
RUN curl -k -SL "https://github.com/sabnzbd/sabnzbd/archive/${SERVICE_VERSION}.tar.gz" \
	| tar -xzf - -C ${SERVICE_INSTALL_DIR} --strip-components=1


# install dependencies
RUN bash -c "source activate ${CONDA_ENV} && \
                pip install cheetah3==3.1.0 cryptography==2.4.2 sabyenc==3.3.5 && \
                python tools/make_mo.py"


# SUPERVISOR -------------------------------------------------------
# add supervisor default configuration
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
# add supervisor service configuration
COPY files/supervisord-${SERVICE_NAME}.conf /etc/supervisor/conf.d/supervisord-${SERVICE_NAME}.conf


# DOCKER RUN PARAMETERS ----------------------------------------------
# will contain service data and configuration
VOLUME /data
# will contain root of downloaded files
VOLUME /download

# supervisor web interface
EXPOSE 9999

# service port
EXPOSE ${SERVICE_PORT}

# service port secured
EXPOSE ${SERVICE_PORT_SECURED}

# entrypoint
COPY files/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# default command
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]

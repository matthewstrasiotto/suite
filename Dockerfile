FROM ubuntu:20.04
ARG LOCAL_MIRROR_SUBDOMAIN
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH $PYTHONPATH:/app/

RUN useradd --create-home --shell /bin/bash vagrant
ADD vagrant /build

RUN . /build/00_su_change_mirror.sh

RUN cd /build \
      && apt-get update \
      && bash 001_su_deps.sh \
      && bash 01_su_python.sh \
      && bash 03_su_nodejs.sh \
      && bash 050_su_config_env.sh

# setup tools
# RUN apt-get update --yes --force-yes
# RUN apt-get install --yes --force-yes build-essential python python-setuptools curl python-pip libssl-dev
# RUN apt-get update --yes --force-yes
# RUN apt-get install --yes --force-yes python-software-properties python-mysqldb libmysqlclient-dev libffi-dev libssl-dev python-dev
# RUN curl -sL https://deb.nodesource.com/setup | bash -
# RUN sudo apt-get --yes --force-yes install nodejs

RUN apt-get install --yes --force-yes nginx supervisor


RUN apt-get install --yes python-is-python3

# Add and install Python modules
ADD requirements.txt /app/requirements.txt
ADD build.sh /app/build.sh

# USER vagrant
RUN cd /app; bash build.sh
# RUN cd /app; pip install -r requirements.txt

# Bundle app source
ADD . /app


RUN cd /app/ && make build

# Expose - note that load balancer terminates SSL
EXPOSE 80

RUN    ln -s /_virtualenv/bin/celery /usr/local/bin/celery \
    && ln -s /_virtualenv/bin/uwsgi  /usr/local/bin/uwsgi

ADD conf /conf

# configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
      && rm /etc/nginx/sites-enabled/default \
      && ln -s /conf/nginx-app.conf /etc/nginx/sites-enabled/ \
      && ln -s /conf/supervisor-app.conf /etc/supervisor/conf.d/

RUN    apt-get install --yes git \
    && pip install git+https://github.com/coderanger/supervisor-stdout

# RUN
CMD ["supervisord", "-n"]


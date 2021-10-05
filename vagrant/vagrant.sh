#!/bin/bash
set -e


PIP_URL=https://bootstrap.pypa.io/pip/3.4/get-pip.py
PIP_URL=https://bootstrap.pypa.io/get-pip.py
# This file is used by the Vagrantfile to set up the dev environment

sudo apt-get update

sudo apt-get install --yes --force-yes zip unzip python python-dev \
    python3-dev \
    build-essential curl redis-server python-setuptools
easy_install -U pip || curl "$PIP_URL" -o get-pip.py && python3 get-pip.py
rm get-pip.py

debconf-set-selections <<< 'mysql-server mysql-server/root_password password bacon'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password bacon'
apt-get update --yes --force-yes

apt-get install --yes --force-yes python3-software-properties \
  python3-mysqldb mysql-server \
  libmysqlclient-dev default-libmysqlclient-dev \
  libffi-dev libssl-dev

printf "[client]\nuser = root\npassword = bacon" >> ~/.my.cnf

service mysql restart
mysql -e "create database dev;"


NODE_SCRIPT_URL="https://deb.nodesource.com/setup_14.x"

# For now, we need to install ca-certificates for node install to work
# https://github.com/nodesource/distributions/issues/1266
sudo apt-get --yes --force-yes install ca-certificates
curl -sL "$NODE_SCRIPT_URL" | bash -
apt-get update --yes --force-yes

sudo apt-get --yes --force-yes install nodejs

# let's get some docker going too
hash docker || curl -sSL https://get.docker.com/ | sh

# have to do some weird shit to get nodejs to work without sudo -.-
su vagrant -l -c 'npm config set prefix ~/npm'
echo 'export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH"' >> /home/vagrant/.bashrc
echo 'export ENV="dev"' >> /etc/profile
echo 'export PYTHONPATH="/vagrant/"' >> /etc/profile

# Get some virtualenv shit going all up in here
pip install virtualenv
echo "source /vagrant-venv/bin/activate" >> $HOME/.bashrc
echo "source /vagrant-venv/bin/activate" >> /home/vagrant/.bashrc

# Install cron job
echo '* * * * * root curl --user staffjoydev: http://suite.local/api/v2/internal/cron/' >> /etc/crontab

cd /vagrant/ && rm -rf vagrant-venv && virtualenv vagrant-venv

rm -rf /vagrant-venv && virtualenv /vagrant-venv

source /vagrant-venv/bin/activate && export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH" && \
  export ENV="dev" && cd /vagrant/ && \
  make build && \
  #make dev-requirements && \
  make db-deploy
python /vagrant/dev-sudo.py


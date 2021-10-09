
PIP_URL=https://bootstrap.pypa.io/pip/3.4/get-pip.py
PIP_URL=https://bootstrap.pypa.io/get-pip.py
# This file is used by the Vagrantfile to set up the dev environment

sudo apt-get update

sudo apt-get install --yes --force-yes \
  zip unzip \
  python python-dev \
  python3-dev \
  python-setuptools \

easy_install -U pip || curl "$PIP_URL" -o get-pip.py && python3 get-pip.py
rm get-pip.py

apt-get install --yes --force-yes \
  python3-software-properties \
  python3-mysqldb

set -e

apt-get install --yes --force-yes \
  build-essential curl \
  apt-utils \
  libmysqlclient-dev default-libmysqlclient-dev \
  libffi-dev libssl-dev

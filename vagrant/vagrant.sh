#!/bin/bash
set -e


cd /vagrant/ && rm -rf vagrant-venv && virtualenv vagrant-venv

rm -rf /vagrant-venv && virtualenv /vagrant-venv

source /vagrant-venv/bin/activate && export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH" && \
  export ENV="dev" && cd /vagrant/ && \
  make build && \
  #make dev-requirements && \
  make db-deploy
python /vagrant/dev-sudo.py


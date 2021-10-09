#!/bin/bash
set -e

cd /app/ 

# Cleanup previous venv if exists
if [ -d vagrant-venv ]; then
  rm -rf vagrant-venv 
  # we don't want a virtualenv inside the project folder
  # virtualenv vagrant-venv
fi

if [ -d /vagrant-venv ]; then
  rm -rf /vagrant-venv 
fi

virtualenv /vagrant-venv

source /vagrant-venv/bin/activate \
  && export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH" \
  && export ENV="dev" \
  && cd /app/ \
  && make build  \
  && make db-deploy
  # && make dev-requirements \

python /app/dev-sudo.py


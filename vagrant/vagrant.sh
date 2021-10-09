#!/bin/bash
set -e

cd /app/ 

# Cleanup previous venv if exists
if [ -d _virtualenv ]; then
  rm -rf _virtualenv 
  # we don't want a virtualenv inside the project folder
  # virtualenv _virtualenv
fi

if [ -d /_virtualenv ]; then
  rm -rf /_virtualenv 
fi

virtualenv /_virtualenv

source /_virtualenv/bin/activate \
  && export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH" \
  && export ENV="dev" \
  && cd /app/ \
  && make build  \
  && make db-deploy
  # && make dev-requirements \

python /app/dev-sudo.py


#!/bin/sh
set -e

source /vagrant/vagrant-venv/bin/activate

# We install a second time during a deploy due to google being a butthead 
# TODO - is this still necessary!?
pip install -r requirements.txt

npm install -g less
npm install -g eslint

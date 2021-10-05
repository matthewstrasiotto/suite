#!/bin/sh
set -e

source /vagrant-venv/bin/activate

# Setuptools 58 removes use_2to3 support, which some old packages depend on
pip install 'setuptools<58.0.0'
# We install a second time during a deploy due to google being a butthead 
# TODO - is this still necessary!?
pip install -r requirements.txt

npm install -g less
npm install -g eslint

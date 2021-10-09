#!/bin/sh
set -e

python -m pip install virtualenv

if [ ! -d /_virtualenv ]; then
 python -m virtualenv /_virtualenv
fi

source /_virtualenv/bin/activate
# Setuptools 58 removes use_2to3 support, which some old packages depend on
pip install 'setuptools<58.0.0'
pip install uwsgi

# We install a second time during a deploy due to google being a butthead 
# TODO - is this still necessary!?
pip install -r requirements.txt

npm install -g less
npm install -g eslint

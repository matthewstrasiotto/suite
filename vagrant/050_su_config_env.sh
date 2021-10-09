#!/bin/bash


# have to do some weird shit to get nodejs to work without sudo -.-
su vagrant -l -c 'npm config set prefix ~/npm'
echo 'export PATH="$PATH:$HOME/npm/bin:/home/vagrant/node_modules/.bin:$PATH"' >> /home/vagrant/.bashrc
echo 'export ENV="dev"' >> /etc/profile
echo 'export PYTHONPATH="/vagrant/"' >> /etc/profile

# Get some virtualenv shit going all up in here
pip install virtualenv
echo "source /_virtualenv/bin/activate" >> $HOME/.bashrc
echo "source /_virtualenv/bin/activate" >> /home/vagrant/.bashrc

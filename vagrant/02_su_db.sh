#!/bin/bash

debconf-set-selections <<< 'mysql-server mysql-server/root_password password bacon'

debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password bacon'
apt-get update --yes --force-yes

apt-get install --yes --force-yes \
  redis-server \
  mysql-server 

printf "[client]\nuser = root\npassword = bacon" >> ~/.my.cnf

service mysql restart
mysql -e "create database dev;"

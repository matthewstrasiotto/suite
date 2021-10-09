#!/bin/bash

NODE_SCRIPT_URL="https://deb.nodesource.com/setup_14.x"

# For now, we need to install ca-certificates for node install to work
# https://github.com/nodesource/distributions/issues/1266
sudo apt-get --yes --force-yes install ca-certificates
curl -sL "$NODE_SCRIPT_URL" | bash -
apt-get update --yes --force-yes

sudo apt-get --yes --force-yes install nodejs


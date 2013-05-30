#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

echo "Installind node.js"
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install nodejs

npm install -g yo grunt-cli bower
npm install grunt-contrib-sass
npm install grunt-contrib-coffee
echo "Node.js with yo, grunt-cli and bower installed"

#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=$(dirname $0)
pluginsDirectory=$baseDirectory/plugins

apt-get update --fix-missing

# System wide
echo "Installing system wide applications..."
command -v javac || apt-get install -y openjdk-7-jdk
apt-get install -y ant curl git openssh-server unzip

# Etckeeper
$pluginsDirectory/etckeeper/script/00-install.sh
$pluginsDirectory/etckeeper/script/20-config.sh

# Apache 2
$pluginsDirectory/apache2/script/00-install.sh
$pluginsDirectory/apache2/script/20-vhosts.sh

# PHP 5
$pluginsDirectory/php5/script/php.sh

# Memcached
apt-get install -y memcached

# SQL
$pluginsDirectory/sql/script/00-install.sh

# MongoDB
apt-get install -y mongodb

# RockMongo
wget http://rockmongo.com/downloads/go?id=10 -O rockmongo.zip; unzip rockmongo.zip
mkdir -p /var/www/mongo.lamp
mv -T rockmongo /var/www/mongo.lamp/web
rm rockmongo.zip

# Other utils
apt-get install -y coffeescript ruby-compass

# Webkit to PDF and Image
$pluginsDirectory/wkhtmlto/script/00-install.sh

# Setting bashrc
echo "Setting bashrc..."
cp $baseDirectory/bash.bashrc ~/.bashrc
cp $baseDirectory/bash.bashrc /etc/bash.bashrc

# Jenkins
$pluginsDirectory/jenkins/script/jenkins.sh

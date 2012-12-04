#!/bin/sh

# System wide
echo "Installing system wide applications..."
apt-get -y install ant curl git openssh-server etckeeper

# Etckeeper settings
echo "Setting up etckeeper..."
cp etckeeper.conf /etc/etckeeper/etckeeper.conf
etckeeper init
etckeeper commit "Initial commit"

# Apache 2
apt-get install -y apache2 libapache2-mod-xsendfile apache2-mpm-itk
a2enmod vhost_alias
a2enmod rewrite
a2enmod xsendfile

a2dissite default
a2dissite 000-default
cp apache2/vhost /etc/apache2/sites-available/vhost
a2ensite vhost
service apache2 restart

# PHP 5
php5/script/php.sh

# Memcached
apt-get install -y memcached

# MySQL
apt-get install -y mysql-server
apt-get install -y phpmyadmin

# MongoDB
apt-get install -y mongodb
ln -s /etc/php5/mods-available/mongo.ini /etc/php5/conf.d/20-mongo.ini

# RockMongo
wget http://rockmongo.com/downloads/go?id=10 -O rockmongo.zip; unzip rockmongo.zip
mkdir -p /var/www/lamp/mongo
mv -T rockmongo /var/www/lamp/mongo/web
rm rockmongo.zip

# Other utils
apt-get install -y coffeescript ruby-compass

# Setting bashrc
echo "Setting bashrc..."
cp bash.bashrc ~/.bashrc
cp bash.bashrc /etc/bash.bashrc

# Jenkins
jenkins/script/jenkins.sh

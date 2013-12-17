#!/bin/sh

apt-get install -y apache2 libapache2-mod-xsendfile apache2-mpm-itk
a2enmod vhost_alias
a2enmod rewrite
a2dismod mpm_event
a2enmod mpm_itk

service apache2 restart

chown -R lamp.lamp /var/www

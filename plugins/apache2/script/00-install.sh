#!/bin/sh

apt-get install -y apache2 libapache2-mod-xsendfile apache2-mpm-itk
a2enmod vhost_alias
a2enmod rewrite
a2enmod xsendfile

a2dissite default
a2dissite 000-default
service apache2 reload

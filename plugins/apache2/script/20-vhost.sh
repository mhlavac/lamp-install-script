#!/bin/sh

a2dissite default
a2dissite 000-default
cp ../config/vhost /etc/apache2/sites-available/vhost
a2ensite vhost
service apache2 reload

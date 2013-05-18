#!/bin/sh

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=`dirname $(readlink -f $0)`
log=/var/log/watch_vhosts.log

echo "Creating vhost for domain: $1" >> $log

# create public web & logs directories
mkdir -p /var/www/$1/web >> $log 2>&1
mkdir -p /var/www/$1/logs >> $log 2>&1
chown -R lamp.lamp /var/www/$1

# create & enable vhost
VHOST_SETTINGS="
<VirtualHost *:80>
    ServerName $1
    ServerAlias *.$1
    DocumentRoot /var/www/$1/web
    XSendFilePath /var/www/$1
    <Directory /var/www/$1/web>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog /var/www/$1/logs/error.log
    LogLevel debug
    CustomLog /var/www/$1/logs/access.log combined
    AssignUserId lamp lamp
</VirtualHost>"
echo "$VHOST_SETTINGS" > /etc/apache2/sites-available/$1  2>> $log
a2ensite $1 >> $log 2>&1
sleep 0.1
service apache2 reload >> $log 2>&1

# regenerate DNS record
$baseDirectory/bind-views.sh >> $log 2>&1

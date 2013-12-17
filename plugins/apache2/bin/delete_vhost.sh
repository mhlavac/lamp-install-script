#!/bin/sh

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=`dirname $(readlink -f $0)`
log=/var/log/watch_vhosts.log

if [ ! -f /etc/apache2/sites-available/$1.conf ]; then
  echo "vhost for domain '$1' doesn't exist" >> $log
  exit 1
fi

echo "Removing vhost for domain: $1" >> $log 2>&1

# regenerate DNS record
sleep 0.5
$baseDirectory/bind-views.sh >> $log 2>&1

# disable & remove vhost
a2dissite $1 >> $log 2>&1
sleep 0.1
service apache2 reload >> $log 2>&1
rm /etc/apache2/sites-available/$1.conf >> $log 2>&1

#!/bin/sh

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

$log=/var/log/watch_vhosts.log

if [ ! -f /etv/apache2/sites-available/$1 ]; then
  echo "vhost for domain '$1' doesn't exist" > $log
  exit 1
fi

echo "Removing vhost for domain: $1" >> $log 2>&1

# remove DNS record
sed "/\/\/ $1 start \/\//,/\/\/ $1 end \/\//d" /etc/bind/named.conf.local > /tmp/named.conf.local.tmp 2>> $log
mv /tmp/named.conf.local.tmp /etc/bind/named.conf.local >> $log 2>&1
sleep 0.1
service bind9 reload >> $log 2>&1

# disable & remove vhost
a2dissite $1 >> $log 2>&1
sleep 0.1
service apache2 reload >> $log 2>&1
rm /etc/apache2/sites-available/$1 >> $log 2>&1

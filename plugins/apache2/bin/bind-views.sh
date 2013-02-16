#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=`dirname $(readlink -f $0)`

rm -f /etc/bind/named.conf.local.dev
rm -f /etc/bind/db.local.dev.*

if [ $(grep -c 'include "/etc/bind/named.conf.local.dev";' /etc/bind/named.conf.local) -eq 0 ]; then
  echo 'include "/etc/bind/named.conf.local.dev";' >> /etc/bind/named.conf.local
fi

if [ $(grep -c 'view' /etc/bind/named.conf.default-zones) -eq 0 ]; then
  echo "view \"default\" {\n" > /etc/bind/named.conf.default-zones.tmp
  cat /etc/bind/named.conf.default-zones >> /etc/bind/named.conf.default-zones.tmp
  echo "\n};" >> /etc/bind/named.conf.default-zones.tmp
  mv /etc/bind/named.conf.default-zones.tmp /etc/bind/named.conf.default-zones
fi

for dev in $(ifconfig | grep -E '^[^ ]' | awk '{print $1;}'); do
  ip=$(ifconfig $dev | awk -F[:\ ] '/inet addr:/ {print $13;}')
  ip6=$(ifconfig $dev | awk '/inet6 addr: / {print $3;}' | sed 's/\/.*$//')

  if [ -z $ip ] && [ -z $ip6 ]; then
    continue
  fi

  zones=""
  for dir in $(find /var/www/* -maxdepth 0 -type d); do
    domain=$(basename $dir)
    zones="${zones}\\n  zone \\\"$domain\\\" { type master; file \\\"\\/etc\\/bind\\/db.local.dev.$dev\\\"; };"
  done

  cat $baseDirectory/bind.template |\
    sed "s/<dev>/$dev/g" |\
    sed "s/<ip>/$ip;/g" |\
    sed "s/<ip6>/$ip6;/g" |\
    sed "s/<zones>/$zones/g" >> /etc/bind/named.conf.local.dev

  if [ -z $ip6 ]; then
    pattern="<ip6>"
  elif [ -z $ip ]; then
    pattern="<ip>"
  else
    pattern="<i_dont_exist>"
  fi

  cat $baseDirectory/db.template |\
    grep -v "$pattern" |\
    sed "s/<ip>/$ip/g" |\
    sed "s/<ip6>/$ip6/g" > /etc/bind/db.local.dev.$dev
done

sleep 0.1
service bind9 reload
rndc flush

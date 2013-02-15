#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=`dirname $(readlink -f $0)`

if [ $# -gt 1 ]; then
  echo "Usage: $0 [ <ip address> ]" >&2
  exit 1
fi

ipRegex="^((25[0-5]|2[0-4][0-9]|(1[0-9]?)?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|(1[0-9]?)?[0-9])$"

if [ $# -eq 1 ]; then
  if [ $(echo $1 | grep -Ec $ipRegex) -eq 1 ]; then
    ip=$1
    echo "Manually specified IP: $ip"
  else
    echo "Not valid IP" >&2
    exit 1
  fi
fi

if [ -z $ip ]; then
  # try to detect IP of format 192.169.*.* - pick the last one (if any)
  ip=$(ifconfig | awk -F[:\ ] '/192\.168\./ {print $13;}' | tail -n 1)
fi

if [ -z $ip ]; then
  # detect IP of the last network device excluding loopback device
  ip=$(ifconfig | awk -F[:\ ] '/inet addr:/ {print $13;}' | grep -vF 127.0.0.1 | tail -n 1)
fi

if [ -z $ip ]; then
  # fallback to localhost
  ip="127.0.0.1"
fi

if [ $# -eq 0 ]; then
  echo "Detected IP: $ip"
fi

pattern="s/<ip>/$ip/g"

sed $pattern $baseDirectory/db.local.dev.template > /etc/bind/db.local.dev

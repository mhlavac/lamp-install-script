#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

add-apt-repository -y ppa:cwchien/gradle
apt-get update
apt-get install gradle-1.9

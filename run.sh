#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

repo="mhlavac/lamp-install-script"
if [ $# -gt 0 ]; then
  repo=$1
fi

branch="master"
if [ $# -gt 1 ]; then
  branch=$2
fi

if [ $# -gt 2 ]; then
  echo "Usage: $0 [repository] [branch]" >&2
  exit 1
fi

wget -O lamp.tar.gz https://github.com/$repo/archive/$branch.tar.gz
tar -xzf lamp.tar.gz
rm lamp.tar.gz
mv lamp-install-script-* lamp-install-script
lamp-install-script/install.sh
rm -rf lamp-install-script

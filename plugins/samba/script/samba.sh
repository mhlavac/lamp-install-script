#!/bin/sh

# -------------------------------------------
# Simple Samba installation script for my LAMP virtual server
# Author Martin Hlavac
# Thanks to article at Ubuntu Server Guide http://ubuntuserverguide.com/2012/06/install-samba-server-ubuntu-server-1204-lts.html
# -------------------------------------------

baseDirectory=$(dirname $0)

echo "Installing samba..."
apt-get install -y samba cifs-utils

echo "Configuring samba..."
cp $baseDirectory/../config/smb.conf /etc/samba/smb.conf
mkdir -p /srv/samba/share
chown lamp.lamp /srv/samba/share

echo "Adding lamp as samba user..."
smbpasswd -a lamp
service smbd restart

echo "You can now start using samba server by entering:"
ipAddress=`ip -f inet addr show eth0 | grep inet | sed -r -e 's/[^0-9]+(([0-9]+(\.)*)+).+/\1/g'`
echo '\\\\'$ipAddress'\'
echo "You can add new files or directories in /srv/samba/share"

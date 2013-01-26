#!/bin/sh

baseDirectory=$(dirname $0)

mkdir -p /usr/share/lamp/
cp $baseDirectory/../bin/* /usr/share/lamp/
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_CREATE
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_MOVED_TO
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_DELETE
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_MOVED_FROM

# DNS
apt-get install -y bind9 dnsutils

# resolv.conf
echo -e "\nnameserver 127.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
resolvconf -u

# incron
apt-get install -y incron
echo -e "\nroot" >> /etc/incron.allow
incrontab $baseDirectory/../config/incrontab
service incron reload

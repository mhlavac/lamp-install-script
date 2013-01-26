#!/bin/sh

baseDirectory=$(dirname $0)

# iNotify tools
apt-get install -y incron
echo -e "\nroot" >> /etc/incron.allow

# DNS
apt-get install -y bind9 dnsutils

# resolv.conf
echo -e "\nnameserver 127.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
resolvconf -u

cp $baseDirectory/../bin/* /usr/share/lamp/
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_CREATE
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_MOVED_TO
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_DELETE
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_MOVED_FROM
incrontab $baseDirectory/../config/incrontab
service incrontab reload

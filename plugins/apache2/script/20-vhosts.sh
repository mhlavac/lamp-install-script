#!/bin/sh

baseDirectory=$(dirname $0)

mkdir -p /usr/share/lamp/
cp $baseDirectory/../bin/* /usr/share/lamp/
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_CREATE
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_MOVED_TO
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_DELETE
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_MOVED_FROM

# for compatibility - in some implementations of incron ",IN_ISDIR" is appended to event name
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_CREATE,IN_ISDIR
ln -s create_vhost.sh /usr/share/lamp/vhost_IN_MOVED_TO,IN_ISDIR
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_DELETE,IN_ISDIR
ln -s delete_vhost.sh /usr/share/lamp/vhost_IN_MOVED_FROM,IN_ISDIR

# DNS
apt-get install -y bind9 dnsutils
ip=$(ifconfig | awk -F[:\ ] '/192.168/ {print $13;}' | tail -n 1)
if [ "$ip" == "" ]; then
  ip=$(ifconfig | awk -F[:\ ] '/inet addr:/ {print $13;}' | grep -vF 127.0.0.1 | tail -n 1)
fi
pattern="s/<ip>/$ip/g"
sed $pattern $baseDirectory/../config/db.local.dev > /etc/bind/db.local.dev

# resolv.conf
echo "\nnameserver 127.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
resolvconf -u

# incron
apt-get install -y incron
echo -e "\nroot" >> /etc/incron.allow
incrontab $baseDirectory/../config/incrontab
service incron reload

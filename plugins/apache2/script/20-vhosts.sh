#!/bin/sh

baseDirectory=$(dirname $0)

mkdir -p /usr/share/lamp/
cp $baseDirectory/../bin/* /usr/share/lamp/

echo 'export PATH="$PATH:/usr/share/lamp"' >> /etc/profile.d/99-lamp.sh
chmod a+x /etc/profile.d/99-lamp.sh

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
/usr/share/lamp/bind9-ip-configure.sh

# resolv.conf
echo "\nnameserver 127.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
resolvconf -u

# incron
apt-get install -y incron
echo -e "\nroot" >> /etc/incron.allow
incrontab $baseDirectory/../config/incrontab
service incron reload

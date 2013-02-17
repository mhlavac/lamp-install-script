#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# MySQL
apt-get install -y mysql-server

# phpMyAdmin
apt-get install -y phpmyadmin
mkdir /var/www/mysql.lamp
rm -rf /var/www/mysql.lamp/web
ln -s /usr/share/phpmyadmin /var/www/mysql.lamp/web

# disable /phpmyadmin aplias
cp /etc/phpmyadmin/apache.conf /etc/phpmyadmin/apache.conf.old
cat /etc/phpmyadmin/apache.conf.old | sed 's/^Alias/#Alias/g' > /etc/phpmyadmin/apache.conf
rm /etc/phpmyadmin/apache.conf.old
service apache2 reload

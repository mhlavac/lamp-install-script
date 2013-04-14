#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=$(dirname $0)

# MySQL
echo "Installing mysql server..."
debconf-set-selections <<< 'mysql-server- mysql-server/root_password password lamp'
debconf-set-selections <<< 'mysql-server- mysql-server/root_password_again password lamp'
apt-get install -y mysql-server

# phpMyAdmin
echo "Installing phpmyadmin"
debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password lamp'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password lamp'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password lamp'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
apt-get install -y phpmyadmin
mkdir /var/www/mysql.lamp
rm -rf /var/www/mysql.lamp/web
ln -s /usr/share/phpmyadmin /var/www/mysql.lamp/web

# disable /phpmyadmin aplias
cp /etc/phpmyadmin/apache.conf /etc/phpmyadmin/apache.conf.old
cat /etc/phpmyadmin/apache.conf.old | sed 's/^Alias/#Alias/g' > /etc/phpmyadmin/apache.conf
rm /etc/phpmyadmin/apache.conf.old
service apache2 reload

# automatic root login
cp /etc/phpmyadmin/config.ing.php /etc/phpmyadmin/config.ing.php.old
cp baseDirectory/../config/config.inc.php /etc/phpmyadmin/config.ing.php

echo "You can start using phpmyadmin by entering http://mysql.lamp in your browser"

#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=$(dirname $0)

# MySQL
echo "Installing mysql server..."
echo 'mysql-server- mysql-server/root_password password lamp' | debconf-set-selections
echo 'mysql-server- mysql-server/root_password_again password lamp' | debconf-set-selections
apt-get install -y mysql-server
echo "Mysql server installed."

# phpMyAdmin
echo "Installing phpmyadmin"
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password lamp' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password lamp' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password lamp' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -y phpmyadmin
mkdir /var/www/mysql.lamp
sleep 0.5
rm -rf /var/www/mysql.lamp/web

ln -s /usr/share/phpmyadmin /var/www/mysql.lamp/web

# disable /phpmyadmin aplias
cp /etc/phpmyadmin/apache.conf /etc/phpmyadmin/apache.conf.old
cat /etc/phpmyadmin/apache.conf.old | sed 's/^Alias/#Alias/g' > /etc/phpmyadmin/apache.conf
rm /etc/phpmyadmin/apache.conf.old
service apache2 reload

# automatic root login
cp /etc/phpmyadmin/config.inc.php /etc/phpmyadmin/config.inc.php.old
cp $baseDirectory/../config/config.inc.php /etc/phpmyadmin/config.inc.php
chown lamp.lamp /etc/phpmyadmin/config.inc.php # domain mysql.lamp is executed as lamp user

echo "PhpMyAdmin installed."
echo "You can start using phpmyadmin by entering http://mysql.lamp in your browser"

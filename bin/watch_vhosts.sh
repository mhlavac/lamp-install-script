#!/bin/sh

create_domain () {
#  echo "new domain: $1"

  mkdir -p /var/www/$1/web
  mkdir -p /var/www/$1/logs

  VHOST_SETTINGS="
<VirtualHost *:80>
    ServerName $1
    ServerAlias *.$1
    DocumentRoot /var/www/$1/web
    XSendFilePath /var/www/$1
    <Directory /var/www/$1/web>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog /var/www/$1/logs/error.log
    LogLevel debug
    CustomLog /var/www/$1/logs/access.log combined
</VirtualHost>"
  echo "$VHOST_SETTINGS" > /etc/apache2/sites-available/$1
  a2ensite $1
  sleep 0.1
  service apache2 reload

  # TODO add bind9
}

delete_domain () {
#  echo "delete domain: $1"

  # remove bind9

  a2dissite $1
  sleep 0.1
  service apache2 reload
  rm /etc/apache2/sites-available/$1
}

dir=/var/www
#dir=$1
if [ ! -d $dir ]; then
  echo "Error: target is not a valid directory" >&2
  exit
fi

inotifywait -m -q -e create -e delete -e move $dir --format '%e %f' | \
while read line; do
  event=$(echo $line | awk '{print $1}')
  domain=$(echo $line | awk '{print $2}')
  if [ $(echo $event | grep -c 'ISDIR$') -eq 0 ]; then
    continue
  fi

  event=$(echo $event | sed 's/,ISDIR$//')
  if [ $event = "CREATE" ] || [ $event = "MOVED_TO" ]; then
    create_domain $domain
  elif [ $event = "DELETE" ] || [ $event = "MOVED_FROM" ]; then
    delete_domain $domain
  fi
done

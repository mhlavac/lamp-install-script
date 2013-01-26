#!/bin/sh

create_domain () {
  echo "Creating vhost for domain: $1"

  # create public web & logs directories
  mkdir -p /var/www/$1/web
  mkdir -p /var/www/$1/logs

  # create & enable vhost
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

  # create DNS record
  ZONE_SETTINGS="
// $1 start //
zone \"$1\" {
	type master;
        file \"/etc/bind/db.local.dev\";
};
// $1 end //
"
  echo "$ZONE_SETTINGS" >> /etc/bind/named.conf.local
  sleep 0.1
  service bind9 reload
}

delete_domain () {
  echo "Removing vhost for domain: $1"

  # remove DNS record
  sed "/\/\/ $domain start \/\//,/\/\/ $domain end \/\//d" /etc/bind/named.conf.local > /tmp/named.conf.local.tmp
  mv /tmp/named.conf.local.tmp /etc/bind/named.conf.local
  sleep 0.1
  service bind9 reload

  # disable & remove vhost
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

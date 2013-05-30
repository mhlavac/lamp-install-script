#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

baseDirectory=$(dirname $0)

a2enmod proxy
a2enmod proxy_http

cp $baseDirectory/../config/jenkins.lamp /etc/apache2/sites-available/jenkins.lamp
a2ensite jenkins.lamp

service apache2 restart # Restart is needed due to proxy and proxy_http mods

#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo "Creating projects.lamp..."
baseDirectory=$(dirname $0)

mkdir -p /var/www/projects.lamp/web
cp $baseDirectory/../bin/index.php /var/www/projects.lamp/web
echo "projects.lamp created."

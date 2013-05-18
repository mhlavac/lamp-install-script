#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo "Creating projects.lamp..."
baseDirectory=$(dirname $0)

destinationDirectory=/var/www/projects.lamp/web
mkdir -p $destinationDirectory
cp $baseDirectory/../bin/index.php $destinationDirectory
chown -R lamp.lamp $destinationDirectory
echo "projects.lamp created."

#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo "Installing postfix..."
echo "postfix postfix/mailname string lamp" | debconf-set-selections
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/recipient_delim string +" | debconf-set-selections
apt-get install -y postfix bsd-mailx
echo "Postfix installed"

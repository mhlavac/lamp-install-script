#!/bin/sh

# root privileges check
if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

baseDirectory=$(dirname $0)

# Postgresql is not officialy supported in non LTS ubuntu versions, that's why
# precise is used. This is tested on Ubuntu 13.10 and it works just fine.
# This problem should be solved in Ubuntu 14.04 LTS for which new version of Postgre will be officialy available

# Postgresql 9.3
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get install postgresql-9.3 phppgadmins
echo "alter user postgres password 'lamp';" | psql

# Only for workspace installation
# pgadmin3
# apt-get install pgadmin3

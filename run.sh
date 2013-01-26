#!/bin/sh

wget -O lamp.tar.gz https://github.com/tomas-pecserke/lamp-install-script/archive/master.tar.gz
tar -xzf lamp.tar.gz
rm lamp.tar.gz
lamp-install-script-master/install.sh
rm -rf lamp-install-script-master

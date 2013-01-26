#!/bin/sh

wget -O lamp.tar.gz https://github.com/tomas-pecserke/lamp-install-script/archive/master.tar.gz
tar -xzf lamp.tar.gz -D lamp-install-script
rm lamp.tar.gz
mv lamp-install-script-* lamp-install-script
lamp-install-script/install.sh
rm -rf lamp-install-script

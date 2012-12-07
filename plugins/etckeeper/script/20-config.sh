#!/bin/sh

baseDirectory=$(dirname $0)

echo "Setting up etckeeper..."
cp $baseDirectory/../config/etckeeper.conf /etc/etckeeper/etckeeper.conf
etckeeper init
etckeeper commit "Initial commit"

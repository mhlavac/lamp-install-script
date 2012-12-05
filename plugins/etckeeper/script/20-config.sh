#!/bin/sh

echo "Setting up etckeeper..."
cp ../config/etckeeper.conf /etc/etckeeper/etckeeper.conf
etckeeper init
etckeeper commit "Initial commit"

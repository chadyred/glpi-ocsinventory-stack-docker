#! /usr/bin/env bash


echo "-- Installations of whole plugins --"

## Extract as same user as glpi owner

echo "-- Install of plugin ocsinventoryng --"

wget -qO- https://github.com/pluginsGLPI/ocsinventoryng/releases/download/1.5.4/glpi-ocsinventoryng-1.5.4.tar.gz | sudo -H -u $(stat -c '%U' glpi) tar xvz -C ./glpi/plugins

echo "-- Install success --"

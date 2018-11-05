#! /usr/bin/env bash

docker-compose up --build -d

while : ; do
    [[ -d "./glpi/plugins" ]] && break
    echo "Pausing until glpi/plugins exists."
    sleep 1
done

wget -qO- https://github.com/pluginsGLPI/ocsinventoryng/releases/download/1.5.4/glpi-ocsinventoryng-1.5.4.tar.gz | tar xvz -C ./glpi/plugins

echo "-- Install success --"
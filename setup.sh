#! /usr/bin/env bash


showLoading() {
  loadingText=$1

  echo -ne "$loadingText\r"

while : ; do
    [[ -d "./glpi/plugins" ]] && break
    echo -ne "$loadingText.\r"
    sleep 0.5
    echo -ne "$loadingText..\r"
    sleep 0.5
    echo -ne "$loadingText...\r"
    sleep 0.5
    echo -ne "\r\033[K"
    echo -ne "$loadingText\r"
    sleep 0.5
  done

  echo "$loadingText...FINISHED"
}

showLoading "Wait for glpi/plugins exists."

echo  "glpi/plugin folder exist"
echo "-- Install of plugin ocsinventoryng --"

## Extract as same user as glpi owner

wget -qO- https://github.com/pluginsGLPI/ocsinventoryng/releases/download/1.5.4/glpi-ocsinventoryng-1.5.4.tar.gz | sudo -H -u $(stat -c '%U' glpi) tar xvz -C ./glpi/plugins

echo "-- Install success --"

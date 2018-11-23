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

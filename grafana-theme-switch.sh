#!/bin/bash

G_INIFILE="/home/grafana/conf/defaults.ini"

if [ "$1" == "sunrise" ] ; then
  sed -i "s/^default_theme = dark/default_theme = light/" $G_INIFILE
  /etc/rc.d/rc.grafana restart
elif [ "$1" == "sunset" ] ; then
  sed -i "s/^default_theme = light/default_theme = dark/" $G_INIFILE
  /etc/rc.d/rc.grafana restart
else
  echo "Usage: $0 [sunset|sunrise]"
  exit 1
fi


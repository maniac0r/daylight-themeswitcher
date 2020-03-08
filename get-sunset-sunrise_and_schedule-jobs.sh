#!/bin/bash

location="LOXX0001"
# Obtain sunrise and sunset raw data from weather.com


sun_times=$( lynx --dump  https://weather.com/weather/today/l/$location | grep "\* Sun" | sed "s/[[:alpha:]]//g;s/*//" )
# Alternative curl/wget solution. In case you wish to use curl or wget instead of lynx comment the above line and uncomment one of the lines below:
#sun_times=$( curl -s  https://weather.com/weather/today/l/$location | sed 's/<span/\n/g' | sed 's/<\/span>/\n/g'  | grep -E "dp0-details-sunrise|dp0-details-sunset" | tr -d '\n' | sed 's/>/ /g' | cut -d " " -f 4,8 )
#sun_times=$( wget -qO-  https://weather.com/weather/today/l/$location | sed 's/<span/\n/g' | sed 's/<\/span>/\n/g'  | grep -E "dp0-details-sunrise|dp0-details-sunset" | tr -d '\n' | sed 's/>/ /g' | cut -d " " -f 4,8 )

# Extract sunrise and sunset times and convert to 24 hour format
sunrise=$(date --date="`echo $sun_times | awk '{ print $1}'` AM" +%R)
sunset =$(date --date="`echo $sun_times | awk '{ print $2}'` PM" +%R)

# Shedule ATD job to switch themes for today...
at "$sunset" <<< "/home/maniac/cron/kibana-theme-switch.sh sunset" > /dev/null
at "$sunrise" <<< "/home/maniac/cron/kibana-theme-switch.sh sunrise" > /dev/null

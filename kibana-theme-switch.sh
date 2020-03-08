#!/bin/bash

ELASTIC_URL='https://127.0.0.1:9200'
KIBANA_URL='http://127.0.0.1:5601/api/saved_objects/config'
USERPASS="mylogin:mypassword"
KIBANA_VERSION=$(curl -s -u "$USERPASS" "$ELASTIC_URL" | grep -A1 '"version"' | grep number | awk -F '"' '{print $4}')
if [ -z "$KIBANA_VERSION" ] ; then
  echo "cannot get elasticsearch version at $ELASTIC_URL"
  exit 1
fi

if [ "$1" == "sunrise" ] ; then
    curl -s -u "$USERPASS" -XPUT -H "Application/json" -H "Content-type: application/json" -H "kbn-xsrf: kibana" $KIBANA_URL/$KIBANA_VERSION -d'
    {
      "attributes": {
         "theme:darkMode": false
      }
    }' > /dev/null
elif [ "$1" == "sunset" ] ; then
    curl -s -u "$USERPASS" -XPUT -H "Application/json" -H "Content-type: application/json" -H "kbn-xsrf: kibana" $KIBANA_URL/$KIBANA_VERSION -d'
    {
      "attributes": {
         "theme:darkMode": true
      }
    }' > /dev/null
else
  echo "Usage: $0 [sunset|sunrise]"
  exit 1
fi


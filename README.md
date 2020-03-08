#  daylight-themeswitcher

.. is set of scripts to allow automatically switch dark and light themes of Grafana and Kibana UIs based on sunset and sunrise information for provided location.
This is intended to run on servers side and making this switch in server defaults, so it will change the theme for all users who are using default UI themes.

In case you can't use lynx , see comments in get-sunset-sunrise_and_schedule-jobs.sh how to use wget/curl.

Theese scripts require cron and at daemon for proper functionality.

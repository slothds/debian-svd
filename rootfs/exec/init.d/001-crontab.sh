#!/bin/bash

for _ctab in /etc/crontab.d/*.crontab
do
    /usr/bin/crontab -u $(echo "${_ctab}" | cut -d'.' -f1) ${_ctab}
done

#!/usr/bin/env bash
_curent=`crontab -l 2>/dev/null`

if [[ -z ${_curent} ]];then
cat <<-EOF | crontab -u root -
SHELL=/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
#####################################################################
# ---------------------------- minutes
# |    ----------------------- hour
# |    |    ------------------ day of month
# |    |    |    ------------- month
# |    |    |    |    -------- day of week
# |    |    |    |    |    --- command
# |    |    |    |    |    |
  *    *    *    *    *    run-parts /etc/periodic/1min
  */15 *    *    *    *    run-parts /etc/periodic/15min
  10   *    *    *    *    run-parts /etc/periodic/hourly
  20   00   *    *    *    run-parts /etc/periodic/daily
  00   01   *    *    1    run-parts /etc/periodic/weekly
  00   02   01   *    *    run-parts /etc/periodic/monthly
EOF
fi

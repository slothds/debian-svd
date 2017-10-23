#!/bin/bash

if [ -n ${TZ} -a "$(cat /etc/timezone)" != ${TZ} ];then
    if [ -f /usr/share/zoneinfo/${TZ} ];then
        cp /usr/share/zoneinfo/${TZ} /etc/localtime
        echo "${TZ}" > /etc/timezone
    else
        echo "WARNING: ${TZ} is wrong time zone."
    fi
fi

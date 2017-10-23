#!/bin/bash
PATH='/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
_exec=( supervisord )

# Including and exporting ENV configs
set -o allexport
for _env in /exec/env.d/*.env
do
    . ${_env}
done
set +o allexport

# Executing prestart init scripts.
for _init in /exec/init.d/*.sh
do
    . ${_init}
done

#!/bin/sh
eval ${_exec[@]} $@

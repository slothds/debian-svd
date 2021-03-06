#!/usr/bin/env bash
_svd=( supervisord --nodaemon )

__terminate_svc() {
    echo "Stopping services..."
    sleep 2
    kill -TERM $(cat /var/run/supervisord.pid)
}

__reconfigs_svc() {
    echo "Reload configuration..."
    sleep 2
    kill -HUP  $(cat /var/run/supervisord.pid) 
}

# Including and exporting ENV configs
set -o allexport
for _env in /exec/env.d/*.env
do
    source ${_env}
done
set +o allexport

# Executing prestart init scripts.
for _init in /exec/init.d/*.sh
do
    source ${_init}
done

#!/usr/bin/env bash
trap __reconfigs_svc HUP
trap __terminate_svc INT QUIT TERM

if [[ -z $@ ]];then
    _svd+=( --pidfile /run/supervisord.pid )
    _svd+=( --logfile /dev/null )
else
    _svd+=( $@ )
fi

eval exec ${_svd[@]}

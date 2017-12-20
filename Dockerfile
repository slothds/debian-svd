FROM       debian:stretch-slim

LABEL      maintainer="sloth@devils.su"

ENV        DEBIAN_FRONTEND=noninteractive

RUN        apt-get update && \
           apt-get -y install tzdata locales apt-utils \
                              supervisor cron && \
           apt-get -y autoremove && apt-get -y autoclean && \
           apt-get -y clean && apt-get -y clean all && \
           rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
RUN        locale-gen en_US.UTF-8 && \
           useradd -Uu 10001 -G users -md /opt/home -s /bin/false runner && \
           mkdir -p /exec/env.d /exec/init.d && \
           ln -sf /proc/1/fd/1 /var/log/docker-stdout.log && \
           ln -sf /proc/1/fd/2 /var/log/docker-stderr.log && \
           chown -R runner:runner /exec && chmod -R 775 /exec
RUN        sed -i 's/\(\[supervisord\]\)/\1\nnodaemon\=true/;' /etc/supervisor/supervisord.conf && \
           sed -i 's/\(logfile\=\).*\( ;.*\)/\1\/dev\/null\2/;' /etc/supervisor/supervisord.conf

COPY       rootfs /

ENTRYPOINT ["/entrypoint.sh"]

STOPSIGNAL SIGTERM

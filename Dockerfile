FROM       debian:stretch-slim

MAINTAINER sloth@devils.su

ENV        DEBIAN_FRONTEND=noninteractive

RUN		   apt-get update && \
           apt-get -y install tzdata locales apt-utils \
                              supervisor cron \
           && \
           locale-gen en_US.UTF-8 && \
           useradd -Uu 10001 -G users -md /opt/home -s /bin/false runner && \
           mkdir -p /exec/env.d /exec/init.d && \
           ln -sf /dev/pts/0 /var/log/docker-out.log && \
           chown -R runner:runner /exec && chmod -R 775 /exec && \
           sed -i 's/\(\[supervisord\]\)/\1\nnodaemon\=true/;' /etc/supervisor/supervisord.conf && \
           ln -sf /dev/pts/0 /var/log/supervisor/supervisord.log && \
           apt-get -y autoremove && \
           apt-get -y clean && apt-get -y clean all && \
           rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY       rootfs /

ENTRYPOINT ["/entrypoint.sh"]

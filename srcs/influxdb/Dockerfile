FROM influxdb:alpine

USER root

COPY srcs/install.sh /tmp/install.sh
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sh /tmp/install.sh && rm -f /tmp/install.sh

EXPOSE 8086

ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf

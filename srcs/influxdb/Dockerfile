FROM alpine

USER root

COPY srcs/install.sh /tmp/install.sh

RUN sh /tmp/install.sh && rm -f /tmp/install.sh

COPY srcs/telegraf.conf /etc/telegraf.conf

EXPOSE 8086

ENTRYPOINT /etc/init.d/telegraf start; influxd

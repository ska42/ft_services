FROM influxdb:alpine

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

EXPOSE 8086

ENTRYPOINT telegraf

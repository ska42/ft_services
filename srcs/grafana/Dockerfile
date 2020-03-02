FROM grafana/grafana:6.4.0-beta1
 
USER root

COPY srcs/install.sh /tmp/install.sh
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sh /tmp/install.sh && rm -f /tmp/install.sh

EXPOSE 3000

ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf

FROM alpine
 
USER root

COPY srcs/install.sh /tmp/install.sh

RUN sh /tmp/install.sh && rm -f /tmp/install.sh
COPY srcs/telegraf.conf /etc/telegraf.conf
COPY srcs/datasources.yml /usr/share/grafana/conf/provisioning/datasources/
COPY srcs/dashboard.yml /usr/share/grafana/conf/provisioning/dashboards/

EXPOSE 3000

WORKDIR /usr/share/grafana

ENTRYPOINT /etc/init.d/telegraf start; /usr/sbin/grafana-server --config=/etc/grafana.ini

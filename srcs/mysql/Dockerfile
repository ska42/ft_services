FROM alpine

USER root

COPY srcs/install.sh /tmp/install.sh
COPY srcs/start.sh /tmp/start.sh

RUN sh /tmp/install.sh 

COPY srcs/telegraf.conf /etc/telegraf.conf
COPY srcs/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT /etc/init.d/telegraf start; sh /tmp/start.sh

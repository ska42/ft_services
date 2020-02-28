FROM alpine

COPY srcs/install.sh /tmp/install.sh
COPY srcs/start.sh /tmp/start.sh
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sh /tmp/install.sh 
COPY srcs/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf 

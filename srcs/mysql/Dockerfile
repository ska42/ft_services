FROM alpine

COPY srcs/install.sh /tmp/install.sh
COPY srcs/start.sh /tmp/start.sh

RUN sh /tmp/install.sh 
COPY srcs/my.cnf /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT sh /tmp/start.sh

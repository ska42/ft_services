FROM alpine

USER root

COPY srcs/install.sh /tmp/install.sh
COPY srcs/config.inc.php /var/www/localhost/htdocs/config.inc.php
ADD  http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.1-all-languages.tar.gz /tmp/

RUN sh /tmp/install.sh && rm -f /tmp/install.sh

COPY srcs/telegraf.conf /etc/telegraf.conf

EXPOSE 80 

ENTRYPOINT /etc/init.d/telegraf start; lighttpd -D -f /etc/lighttpd/lighttpd.conf

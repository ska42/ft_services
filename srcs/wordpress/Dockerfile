FROM alpine

COPY srcs/install.sh /tmp/install.sh
COPY srcs/wp-config.php /var/www/localhost/htdocs/wp-config.php
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD https://fr.wordpress.org/latest-fr_FR.tar.gz /tmp/

RUN sh /tmp/install.sh && rm -f /tmp/install.sh
 
EXPOSE 80

FROM alpine

COPY srcs/install.sh /tmp/install.sh
COPY srcs/wp-config.php /var/www/localhost/htdocs/wp-config.php
ADD https://fr.wordpress.org/latest-fr_FR.tar.gz /tmp/

RUN sh /tmp/install.sh && rm -f /tmp/install.sh
 
EXPOSE 80

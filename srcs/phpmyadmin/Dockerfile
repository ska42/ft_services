FROM alpine

COPY srcs/install.sh /tmp/install.sh
COPY srcs/config.inc.php /var/www/localhost/htdocs/config.inc.php
ADD  http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.1-all-languages.tar.gz /tmp/

RUN sh /tmp/install.sh && rm -f /tmp/install.sh

EXPOSE 80 

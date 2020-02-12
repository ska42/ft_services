FROM alpine

COPY srcs/install.sh /tmp/install.sh
ADD  http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-4.5.0.2-all-languages.tar.gz /tmp/

RUN sh /tmp/install.sh

COPY srcs/config.inc.php /var/www/localhost/htdocs/config.inc.php

EXPOSE 80 

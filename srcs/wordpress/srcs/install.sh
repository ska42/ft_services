#!/bin/sh

apk upgrade
apk add apache2 \
php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib \
 --no-cache

tar -xf /tmp/latest-fr_FR.tar.gz --strip-components=1 -C /var/www/localhost/htdocs
rm /var/www/localhost/htdocs/index.html

echo "ServerName localhost" >> /etc/apache2/conf.d/default.conf

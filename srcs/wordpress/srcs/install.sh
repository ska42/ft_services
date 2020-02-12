#!/bin/sh

apk upgrade
apk add apache2 \
php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib php7-json\
 --no-cache

tar -xf /tmp/latest-fr_FR.tar.gz --strip-components=1 -C /var/www/localhost/htdocs
rm /var/www/localhost/htdocs/index.html
rm /var/www/localhost/htdocs/wp-config-sample.php
rm /var/www/localhost/htdocs/license.txt
rm /var/www/localhost/htdocs/readme.html

sed -i "s/ErrorLog logs\/error.log/Errorlog \/dev\/stderr\nTransferlog \/dev\/stdout/" /etc/apache2/httpd.conf
echo "ServerName localhost" >> /etc/apache2/conf.d/default.conf

#!/bin/sh

apk upgrade
apk add apache2 \
php7 php7-apache2 php7-mbstring php7-openssl php7-session php7-zlib php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom\
 --no-cache

tar -xf /tmp/phpMyAdmin-4.5.0.2-all-languages.tar.gz --strip-components=1 -C /var/www/localhost/htdocs
rm -f /var/www/localhost/htdocs/index.html
rm -f /var/www/localhost/htdocs/config.sample.inc.php

sed -i "s/ErrorLog logs\/error.log/Errorlog \/dev\/stderr\nTransferlog \/dev\/stdout/" /etc/apache2/httpd.conf
echo "ServerName localhost" >> /etc/apache2/conf.d/default.conf

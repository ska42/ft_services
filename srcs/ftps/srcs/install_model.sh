#!/bin/sh

apk upgrade
# Install rc-service & pure-ftpd & ssl
apk add openrc openssl --no-cache
apk add telegraf pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# ssl
yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem 

adduser -D "__FTPS_USERNAME__"
echo "__FTPS_USERNAME__:__FTPS_PASSWORD__" | chpasswd

openrc
touch /run/openrc/softlevel
rc-update add telegraf

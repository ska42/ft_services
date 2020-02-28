#!/bin/sh

apk upgrade

# Install rc-service & pure-ftpd & ssl
apk add openssl --no-cache
apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
apk add supervisor --no-cache
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache


# ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem \
-subj "/C=FR/ST=Anywhere/L=Here/O=42/OU=42/CN=lmartin/emailAddress=lmartin@student.42.fr"

adduser -D "admin"
echo "admin:admin" | chpasswd

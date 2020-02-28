#!/bin/sh

# Install
apk update
apk add openrc --no-cache 
apk add openssl --no-cache 
apk add openssh --no-cache 
apk add supervisor --no-cache
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Request SSL key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=lmartin' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# ssh
adduser -D "admin" 
echo "admin:admin" | chpasswd

openrc
touch /run/openrc/softlevel
rc-update add sshd

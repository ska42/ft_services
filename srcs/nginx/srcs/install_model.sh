#!/bin/sh

# Install
apk add openrc
apk add openssl --no-cache # Certificat SSL
apk add openssh --no-cache # ssh

# Request SSL key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=lmartin' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# ssh
adduser -D "__SSH_USERNAME__" 
echo "__SSH_USERNAME__:__SSH_PASSWORD__" | chpasswd

openrc
touch /run/openrc/softlevel
rc-update add sshd

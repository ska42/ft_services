#!/bin/sh

# Install
apk add openrc --no-cache # rc-service
apk add openssl --no-cache # Certificat SSL
apk add openssh --no-cache # ssh

# Request SSL key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=lmartin' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# ssh
useradd $SSH_USERNAME
echo $SSH_PASSWORD | passwd $SSH_USERNAME --stdin

# Update
rc-update add sshd

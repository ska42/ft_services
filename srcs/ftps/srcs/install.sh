#!/bin/sh

# Install rc-service & vsftpd
apk add openrc
apk add vsftpd

mkdir -p /var/empty
mkdir -p /home/ftp

chown nodoby:nogroup /home/ftp

echo "$FTP_USERNAME\n$FTP_PASSWORD" >> /etc/vsftpd.userlist

openrc
touch /run/openrc/softlevel

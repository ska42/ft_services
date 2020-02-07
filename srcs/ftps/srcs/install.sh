#!/bin/sh

# Install rc-service & vsftpd
apk add openrc --no-cache
apk add vsftpd --no-cache

# create ftp's folders
mkdir -p /var/empty
mkdir -p /home/ftp
chown nodoby:nogroup /home/ftp

# userlist
echo "$FTP_USERNAME\n$FTP_PASSWORD" >> /etc/vsftpd.userlist

openrc
touch /run/openrc/softlevel

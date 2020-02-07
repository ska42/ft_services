#!/bin/sh

# Install rc-service & vsftpd
apk add openrc
apk add vsftpd

mkdir -p /home/ftps
chown -R nobody:nogroup /home/ftps
chmod -R a-w /home/ftps
mkdir /home/ftps/writeable
chmod 777 /home/ftps/writeable
echo "anon" | tee /home/ftps/anon.txt

cat <<EOF | tee /etc/vsftpd/vsftpd.conf
anon_mkdir_write_enable=YES
anon_other_write_enable=YES
anon_root=/home/ftps
anon_upload_enable=YES
anon_world_readable_only=YES
anonymous_enable=YES
ascii_upload_enable=YES
dirmessage_enable=YES
listen=YES
local_enable=YES
ssl_enable=NO
syslog_enable=YES
write_enable=YES
seccomp_sandbox=NO
EOF

openrc
touch /run/openrc/softlevel

FROM alpine

# Config file
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Install script
COPY srcs/install.sh /tmp/install.sh
RUN /tmp/install.sh

EXPOSE 21

CMD rc-service vsftpd restart & rc-update add vsftpd

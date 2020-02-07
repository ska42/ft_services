FROM alpine

# Install script
COPY srcs/install.sh /tmp/install.sh
RUN /tmp/install.sh

EXPOSE 21

CMD rc-service vsftpd restart

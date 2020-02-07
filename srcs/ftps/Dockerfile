FROM alpine

# Install script
COPY srcs/install.sh /tmp/install.sh
RUN /tmp/install.sh

EXPOSE 21 21000

CMD pure-ftpd -Y 2 -p 21000:21000 

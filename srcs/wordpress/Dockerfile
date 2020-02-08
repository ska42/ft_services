FROM alpine

COPY srcs/install.sh /tmp/install.sh
ADD https://fr.wordpress.org/latest-fr_FR.tar.gz /tmp/

RUN sh /tmp/install.sh
 
EXPOSE 80

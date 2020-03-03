FROM alpine 

USER root

# Copy files
COPY srcs/install.sh /tmp/install.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /var/www/localhost/htdocs/index.html

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
# Run Install
RUN sh /tmp/install.sh

EXPOSE 22 80 443

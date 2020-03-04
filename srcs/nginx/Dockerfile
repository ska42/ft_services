FROM alpine 

USER root

# Copy files
COPY srcs/install.sh /tmp/install.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /var/www/localhost/htdocs/index.html

# Run Install
RUN sh /tmp/install.sh 

COPY srcs/telegraf.conf /etc/telegraf.conf
EXPOSE 22 80 443

ENTRYPOINT /etc/init.d/telegraf start; /etc/init.d/sshd start; nginx -g "daemon off;"

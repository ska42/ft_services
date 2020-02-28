FROM nginx:alpine 

# Copy files
COPY srcs/install.sh /tmp/install.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Run Install
RUN sh /tmp/install.sh

EXPOSE 22 80 443

FROM alpine

# Install scripts
COPY srcs/install.sh /tmp/install.sh
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN /tmp/install.sh

EXPOSE 21 21000

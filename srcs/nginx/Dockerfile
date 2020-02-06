FROM nginx:alpine 

COPY srcs/install.sh /tmp/install.sh
COPY srcs/nginx.conf /etc/nginx/nginx.conf

RUN sh /tmp/install.sh

EXPOSE 22 80 443

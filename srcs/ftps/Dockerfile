FROM alpine

# Install script
COPY srcs/install.sh /tmp/install.sh
RUN /tmp/install.sh

EXPOSE 21 

# Let open the cointainer
CMD tail -f /dev/null

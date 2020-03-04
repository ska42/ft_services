#!/bin/sh

apk update
apk add openrc --no-cache
apk add telegraf influxdb --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache 

openrc
touch /run/openrc/softlevel
rc-update add telegraf

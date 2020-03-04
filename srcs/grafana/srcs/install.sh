#!/bin/sh

apk update
apk add openrc --no-cache
apk add grafana telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mkdir -p /etc/grafana/provisioning/dashboards

openrc
touch /run/openrc/softlevel
rc-update add telegraf

#!/bin/bash

apk upgrade
apk add mysql mysql-client --no-cache
apk add supervisor --no-cache
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mkdir -p /run/mysqld
cp -rp /var/run/mysqld /var/run/mysqld.bak

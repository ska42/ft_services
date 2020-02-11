#!/bin/bash

apk upgrade
apk add mysql mysql-client --no-cache

mkdir -p /run/mysqld
cp -rp /var/run/mysqld /var/run/mysqld.bak

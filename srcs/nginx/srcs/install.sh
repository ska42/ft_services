#!/bin/sh

# Install
apk add openrc
apk add openssh

# Update
rc-update add sshd

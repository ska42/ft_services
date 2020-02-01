#!/bin/bash

dir_goinfre=/goinfre/$USER/
dir_archive=$dir_goinfre/images-archives

# Reset All
eval $(minikube docker-env)
kubectl delete -k ./srcs

# delete previous images
docker image rm -f nginx-server
docker image rm -f ftps-server
docker image rm -f wordpress-server
docker image rm -f mysql-server

mkdir -p $dir_archive
# build archive
docker build -t nginx-server srcs/nginx
docker build -t ftps-server srcs/ftps
docker build -t wordpress-server srcs/wordpress
docker build -t mysql-server srcs/mysql
# save to tar file
docker save nginx-server > $dir_archive/nginx-server.tar
docker save ftps-server > $dir_archive/ftps-server.tar
docker save wordpress-server > $dir_archive/wordpress-server.tar
docker save mysql-server > $dir_archive/mysql-server.tar
# load from tar file
docker load < $dir_archive/nginx-server.tar
docker load < $dir_archive/ftps-server.tar
docker load < $dir_archive/wordpress-server.tar
docker load < $dir_archive/mysql-server.tar
# Call kustomization
kubectl apply -k ./srcs

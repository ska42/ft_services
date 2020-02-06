# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmartin <lmartin@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 05:23:46 by lmartin           #+#    #+#              #
#    Updated: 2020/02/06 05:46:55 by lmartin          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

# ================================== VARIABLES =================================

dir_goinfre=/goinfre/$USER/
dir_archive=$dir_goinfre/images-archives
volumes=srcs/volumes

# add minikube env variables
eval $(minikube docker-env)
# =================================== RESET ====================================

# delete yaml
kubectl delete -k ./srcs
kubectl delete pvc wp-pv-claim
kubectl delete pvc mysql-pv-claim
kubectl delete pv wp-pv-volume
kubectl delete pv mysql-pv-volume

# delete previous images
docker image rm -f nginx-server
docker image rm -f ftps-server
docker image rm -f wordpress-server
docker image rm -f mysql-server

# ================================== LAUNCH ====================================

# volume and volume claim
kubectl apply -f $volumes/wp-pv-volume.yaml
kubectl apply -f $volumes/mysql-pv-volume.yaml
kubectl apply -f $volumes/wp-pv-claim.yaml
kubectl apply -f $volumes/mysql-pv-claim.yaml

# create path for archives if doesn't exist
mkdir -p $dir_archive
## Save and get all customized images in minikube
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

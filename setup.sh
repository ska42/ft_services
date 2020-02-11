# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmartin <lmartin@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 05:23:46 by lmartin           #+#    #+#              #
#    Updated: 2020/02/11 06:57:59 by lmartin          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

# ================================== VARIABLES =================================

srcs=./srcs
dir_goinfre=/goinfre/$USER/
dir_archive=$dir_goinfre/images-archives
volumes=srcs/volumes
services=(nginx ftps wordpress mysql)
pvs=(wp mysql)
#ip=$(minikube ip)

# ================================== CONFIG ====================================

# SSH
SSH_USERNAME=admin
SSH_PASSWORD=admin
# FTPS
FTPS_USERNAME=admin
FTPS_PASSWORD=admin
# DB MYSQL 
DB_NAME=mysql
DB_USER=root
DB_PASSWORD=password
DB_HOST=wordpress

cp $srcs/nginx/srcs/install_model.sh $srcs/nginx/srcs/install.sh
cp $srcs/ftps/srcs/install_model.sh $srcs/ftps/srcs/install.sh
cp $srcs/wordpress/srcs/wp-config_model.php $srcs/wordpress/srcs/wp-config.php
sed -i '' s/__SSH_USERNAME__/$SSH_USERNAME/g $srcs/nginx/srcs/install.sh
sed -i '' s/__SSH_PASSWORD__/$SSH_PASSWORD/g $srcs/nginx/srcs/install.sh
sed -i '' s/__FTPS_USERNAME__/$FTPS_USERNAME/g $srcs/ftps/srcs/install.sh
sed -i '' s/__FTPS_PASSWORD__/$FTPS_PASSWORD/g $srcs/ftps/srcs/install.sh
sed -i '' s/__DB_NAME__/$DB_NAME/g $srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_USER__/$DB_USER/g $srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_PASSWORD__/$DB_PASSWORD/g $srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_HOST__/$DB_HOST/g $srcs/wordpress/srcs/wp-config.php

# ================================== MINIKUBE ==================================

# delete all
kubectl delete -k $srcs

# add minikube env variables
eval $(minikube docker-env)

for pv in "${pvs[@]}"
do
	kubectl delete pvc $pv-pv-claim # delete yaml
	kubectl delete pv $pv-pv-volume
	kubectl apply -f $volumes/$pv-pv-volume.yaml # volume and volume claim
	kubectl apply -f $volumes/$pv-pv-claim.yaml
done

# create path for archives if doesn't exist
mkdir -p $dir_archive
## Save and get all customized images in minikube
for service in "${services[@]}"
do
	docker image rm -f $service-image # delete previous images
	docker build -t $service-image srcs/$service # build archive
	docker save $service-image > $dir_archive/$service-image.tar # save to tar file
	docker load < $dir_archive/$service-image.tar #load from tar file
done 

# apply kustomization --> yaml
kubectl apply -k $srcs

rm -f $srcs/nginx/srcs/install.sh
rm -f $srcs/ftps/srcs/install.sh
rm -f $srcs/wordpress/wp-config.php

echo "Minikube IP is : $ip"

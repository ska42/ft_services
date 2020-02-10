# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmartin <lmartin@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 05:23:46 by lmartin           #+#    #+#              #
#    Updated: 2020/02/10 21:51:43 by lmartin          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

# ================================== VARIABLES =================================

srcs=./srcs
dir_goinfre=/goinfre/$USER/
dir_archive=$dir_goinfre/images-archives
volumes=srcs/volumes
services=(nginx ftps wordpress) # mysql)
pvs=(wp) # mysql)

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

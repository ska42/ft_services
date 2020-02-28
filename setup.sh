# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmartin <lmartin@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/06 05:23:46 by lmartin           #+#    #+#              #
#    Updated: 2020/02/18 22:06:15 by lmartin          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash
# ================================== CONFIG ====================================

# SSH
SSH_USERNAME=admin
SSH_PASSWORD=admin
# FTPS
FTPS_USERNAME=admin
FTPS_PASSWORD=admin
# DB MYSQL (Can't change atm)
DB_NAME=wordpress
DB_USER=root
DB_PASSWORD=password
DB_HOST=mysql

# ================================== VARIABLES =================================

# Directories
srcs=./srcs
dir_goinfre=/Users/$USER # /goinfre/$USER at 42 or /sgoinfre - /Users/$USER at home on Mac
docker_destination=$dir_goinfre/docker
dir_minikube=$dir_goinfre/minikube
dir_archive=$dir_goinfre/images-archives
volumes=$srcs/volumes

# You can comment service(s) if you want to test without some.
services=(		\
 	nginx		\
	ftps		\
	wordpress	\
	mysql		\
	phpmyadmin	\
	grafana		\
	influxdb	\
)
# Volumes
pvs=( 			\
	wp 			\
	mysql 		\
	influxdb 	\
)

# ================================== MINIKUBE ==================================

if [[ $1 != "deployment" ]]
then
		# BREW
		which -s brew
		if [[ $? != 0 ]] ; then
			echo "Brew not installed, installling..."
			# Install brew
			rm -rf $HOME/.brew
			git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
			echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc
			source $HOME/.zshrc
		fi
		echo "Updating brew..."
		brew update

		# KUBECTL
		which -s kubectl
		if [[ $? != 0 ]] ; then
			echo "Kubectl not installed, installing..."
			# Install kubectl
			brew install kubectl
		fi

		# MINIKUBE
		which -s minikube
		if [[ $? != 0 ]] ; then
			echo "Minikube not installed, installing..."
			# Install minikube 
			brew install minikube
		fi
		mkdir -p $dir_minikube
		ln -sf $dir_minikube /Users/$USER/.minikube

		# DOCKER
		brew uninstall -f docker docker-compose
		if [ ! -d "/Applications/Docker.app" ] && [ ! -d "~/Applications/Docker.app" ]; then
			echo $'\033[0;34m'Please install $'\033[1;96m'Docker for Mac $'\033[0;34m'from the MSC \(Managed Software Center\)$'\033[0;39m'
			open -a "Managed Software Center"
			read -p $'\033[0;34m'Press\ RETURN\ when\ you\ have\ successfully\ installed\ $'\033[1;96m'Docker\ for\ Mac$'\033[0;34m'...$'\033[0;39m'
		fi
		pkill Docker
		if [ ! -d $docker_destination ]; then
			rm -rf ~/Library/Containers/com.docker.docker ~/.docker
			mkdir -p $docker_destination/{com.docker.docker,.docker}
			ln -sf $docker_destination/com.docker.docker ~/Library/Containers/com.docker.docker
			ln -sf $docker_destination/.docker ~/.docker
		fi
		echo "Opening Docker..."
		open -g -a Docker

		# DOCKER-MACHINE
		which -s docker-machine
		if [[ $? != 0 ]] ; then
			echo "docker-machine not installed, installing..."
			# Install docker-machine
			brew install docker-machine
		fi

		# Stopping docker-machine & minikube if started
		docker-machine stop
		minikube delete

		# Launch docker-machine
		docker-machine create --driver virtualbox default
		docker-machine start

		# Launch Minikube
		minikube start --cpus=4 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000
		minikube addons enable dashboard
		minikube addons enable ingress
		minikube addons enable metrics-server

		#If error
		#VBoxManage hostonlyif remove vboxnet1
	
		minikube ip > /tmp/minikube.ip
fi

# ============================== REPLACE MODELS ================================

MINIKUBE_IP=`cat /tmp/minikube.ip`;

# copy models files
cp $srcs/nginx/srcs/install_model.sh 			$srcs/nginx/srcs/install.sh
cp $srcs/ftps/srcs/install_model.sh 			$srcs/ftps/srcs/install.sh
cp $srcs/ftps/srcs/supervisord_model.conf		$srcs/ftps/srcs/supervisord.conf
cp $srcs/wordpress/srcs/wp-config_model.php		$srcs/wordpress/srcs/wp-config.php
cp $srcs/mysql/srcs/start_model.sh				$srcs/mysql/srcs/start.sh
cp $srcs/wordpress/srcs/wordpress_model.sql		$srcs/wordpress/srcs/wordpress.sql
# telegraf
cp $srcs/telegraf_model.conf					$srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/nginx/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/ftps/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/mysql/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/wordpress/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/phpmyadmin/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/grafana/srcs/telegraf.conf
cp $srcs/telegraf.conf							$srcs/influxdb/srcs/telegraf.conf
# replace strings
sed -i '' s/__SSH_USERNAME__/$SSH_USERNAME/g	$srcs/nginx/srcs/install.sh
sed -i '' s/__SSH_PASSWORD__/$SSH_PASSWORD/g	$srcs/nginx/srcs/install.sh
sed -i '' s/__FTPS_USERNAME__/$FTPS_USERNAME/g	$srcs/ftps/srcs/install.sh
sed -i '' s/__FTPS_PASSWORD__/$FTPS_PASSWORD/g	$srcs/ftps/srcs/install.sh
sed -i '' s/__MINIKUBE_IP__/$MINIKUBE_IP/g		$srcs/ftps/srcs/supervisord.conf
sed -i '' s/__DB_NAME__/$DB_NAME/g				$srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_USER__/$DB_USER/g				$srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_PASSWORD__/$DB_PASSWORD/g		$srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_HOST__/$DB_HOST/g				$srcs/wordpress/srcs/wp-config.php
sed -i '' s/__DB_USER__/$DB_USER/g				$srcs/mysql/srcs/start.sh
sed -i '' s/__DB_PASSWORD__/$DB_PASSWORD/g		$srcs/mysql/srcs/start.sh
sed -i '' s/__MINIKUBE_IP__/$MINIKUBE_IP/g		$srcs/wordpress/srcs/wordpress.sql

# ================================= DEPLOYMENT =================================

# delete all
echo "Delete previous containers..."
kubectl delete -k $srcs >/dev/null 2>&1

# add minikube env variables
eval $(minikube docker-env)

for pv in "${pvs[@]}"
do
	echo "Delete $pv-pv claim & volume..."
	kubectl delete pvc $pv-pv-claim >/dev/null 2>&1 # delete yaml
	kubectl delete pv $pv-pv-volume >/dev/null 2>&1
	echo "Apply $pv-pv claim & volume yaml..."
	kubectl apply -f $volumes/$pv-pv-volume.yaml > /dev/null # volume and volume claim
	kubectl apply -f $volumes/$pv-pv-claim.yaml > /dev/null
done

# create path for archives if doesn't exist
mkdir -p $dir_archive
# copy kuztomization
cp -f $srcs/kustomization_model.yaml $srcs/kustomization.yaml
## Save and get all customized images in minikube
echo "Building images:"
for service in "${services[@]}"
do
	if [[ $2 != "nobuild" ]]
	then
		echo "	$service:"
		echo "		Deleting previous image..."
		docker image rm -f $service-image >/dev/null 2>&1 # delete previous images
		echo "		Building new image..."		
		docker build -t $service-image $srcs/$service > /dev/null # build archive
		echo "		Saving new image..."
		docker save $service-image > $dir_archive/$service-image.tar # save to tar file
		echo "		Loading new image in minikube..."
		docker load < $dir_archive/$service-image.tar > /dev/null #load from tar file
	fi
	echo "  - $service-deployment.yaml" >> $srcs/kustomization.yaml
done 

echo "Creating all containers..."
# apply kustomization --> yaml
kubectl apply -k $srcs > /dev/null

sleep 30

kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql -u root -e 'CREATE DATABASE wordpress;' > /dev/null
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < $srcs/wordpress/srcs/wordpress.sql

#kubectl exec -i $(kubectl get pods | grep influxdb | cut -d" " -f1) -- influx -execute 'CREATE DATABASE influxdb;' > /dev/null

echo "Deleting temporary files..."
rm -f $srcs/telegraf.conf
rm -f $srcs/nginx/srcs/telegraf.conf
rm -f $srcs/ftps/srcs/telegraf.conf
rm -f $srcs/mysql/srcs/telegraf.conf
rm -f $srcs/wordpress/srcs/telegraf.conf
rm -f $srcs/phpmyadmin/srcs/telegraf.conf
rm -f $srcs/grafana/srcs/telegraf.conf
rm -f $srcs/influxdb/srcs/telegraf.conf
rm -f $srcs/nginx/srcs/install.sh
rm -f $srcs/ftps/srcs/install.sh
rm -f $srcs/ftps/srcs/supervisord.conf
rm -f $srcs/wordpress/srcs/wp-config.php
rm -f $srcs/mysql/srcs/start.sh
rm -f $srcs/wordpress/srcs/wordpress.sql
rm -f $srcs/kustomization.yaml

echo "Deployment Done"
echo " 
Minikube IP is : $MINIKUBE_IP - Type 'minikube dashboard' for dashboard
================================================================================
			username:password
ssh:			$SSH_USERNAME:$SSH_PASSWORD (port 22)
ftps:			$FTPS_USERNAME:$FTPS_PASSWORD (port 21)
database:		$DB_USER:$DB_PASSWORD (sql / phpmyadmin)
grafana:		admin:admin
accounts wordpress:
			admin:admin (Admin)
			lmartin:lmartin (Author)
			norminet:norminet (Subscriber)
			visitor:visitor (Subscriber)"

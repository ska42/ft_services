# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    reset.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmartin <lmartin@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/01 02:09:51 by lmartin           #+#    #+#              #
#    Updated: 2020/02/06 05:24:33 by lmartin          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

# ================================= VARIABLES ==================================

# DIRECTORIES
dir_goinfre=/goinfre/$USER
docker_destination=$dir_goinfre/docker
dir_minikube=$dir_goinfre/minikube

# =================================== INSTALL ==================================

# BREW
which -s brew
if [[ $? != 0 ]] ; then
	# Install brew
	rm -rf $HOME/.brew
	git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
	echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc
	source $HOME/.zshrc
fi
brew update

# KUBECTL
which -s kubectl
if [[ $? != 0 ]] ; then
	# Install kubectl
	brew install kubectl
fi

# MINIKUBE
which -s minikube
if [[ $? != 0 ]] ; then
	# Install minikube 
	brew install minikube
fi
mkdir -p $dir_minikube
ln -sf $dir_minikube /Users/$USER/.minikube

# DOCKER
docker_destination=/goinfre/$USER/docker
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
open -g -a Docker

# DOCKER-MACHINE
which -s docker-machine
if [[ $? != 0 ]] ; then
	# Install docker-machine
	brew install docker-machine
fi

# =================================== LAUNCH ===================================

# Stopping docker-machine & minikube if started
docker-machine stop
minikube delete

# Launch docker-machine
docker-machine create --driver virtualbox default
docker-machine start

# Launch Minikube
minikube start --cpus=4 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000 
minikube addons enable ingress

#If error
#VBoxManage hostonlyif remove vboxnet1

# Dashboard
minikube dashboard

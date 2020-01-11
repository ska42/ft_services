#!/bin/bash

# Install brew
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update

# Install kubectl & minikube
brew install kubectl && brew install minikube

# Install docker
read -p "Install virtual-box & docker via MSC, press any key when finished..."

# Symlink docker
ln -s /sgoinfre/goinfre/Perso/$USER/.docker ~/.docker

# Symlink minikube
mkdir -p /sgoinfre/goinfre/Perso/$USER/minikube
ln -s /sgoinfre/goinfre/Perso/$USER/minikube /Users/$USER/.minikube

# Install & Launch docker-machine
brew install docker-machine
docker-machine create --driver virtualbox default
docker-machine start

# Checking
kubectl config view
minikube version
kubectl version

# Minikube
minikube delete
minikube start --cpus=4 --disk-size 11000 --vm-driver virtualbox

# Re-checking
kubectl version
minikube dashboard

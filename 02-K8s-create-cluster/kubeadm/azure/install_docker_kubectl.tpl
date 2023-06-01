#!/bin/bash 

### install docker engine

apt-get update
apt-get install -y git wget

# Install Docker
apt-get install -yq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    lsb-release
    

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get update

apt-get install -yq docker-ce docker-ce-cli containerd.io

### Install kubeadm

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y

#sudo apt-get install -qy kubelet=1.22.4-00 kubectl=1.22.4-00 kubeadm=1.22.4-00
#sudo apt-mark hold kubelet kubeadm kubectl


#sudo apt-get install -y kubernetes-cni nfs-common


#sudo sysctl net.bridge.bridge-nf-call-iptables=1
#sudo swapoff -a

#sudo rm -rf /var/lib/kubelet/*

sudo apt-get install nfs-common -y

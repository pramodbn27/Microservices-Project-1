# Build K8s Cluster using Kubeadm

Resource 

#### install Docker engine

https://docs.docker.com/engine/install/ubuntu/

#### install kubeadm and required packages 

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

#### initialize cluster using kubeadm

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

## Build master and worker instances(1)

This repository will help to create two Ec2 machine

Master Node or Control plane

- Install the Container Runtime (Docker)
- Install the Kubernetes Packages (`kubeadm`, `kubelet`, and `kubectl`)

Worker Node

- Install the Container Runtime (Docker)
- Install the Kubernetes Packages (`kubeadm`, `kubelet`, and `kubectl`)

### Steps to execute this code

```
git clone https://github.com/thedevopsstore/k8s-fundamentals.git

cd 02-K8s-create-cluster/kubeadm-ec2

terraform init

# this code by default executes in us-east-1 region, and if you want to change, please update vars.tf file or pass a variable for region as below

# terraform plan -var AWS_REGION=ap-south-1

terraform plan

terraform apply
```

## intialize the Cluster manually by login into both master and worker nodes

### Cgroup Settings on both nodes


```
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

```
### Initiate the Master Node

```
# enter the pod network ( optional ) to assign cidr for pod network


kubeadm init --pod-network-cidr=192.168.0.0/16

# To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

```
### Join the woker nodes to the created cluster

```
# This below join command will be disabled once you initialize the cluster

## example 

kubeadm join 10.0.101.50:6443 --token u4br39.6eucsm3t4l7icyno \
	--discovery-token-ca-cert-hash sha256:e428c0209b827dd3dc984e3714c72a31293b7b4d6bb328c2445ea7311fee4341 

```

### install the CNI driver

```
# installing calico driver

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml

```

### Validate the Nodes and Pods

```

# Make sure the nodes are ready if not waiting for the CNI driver to be up and running


kubectl get nodes 


# check for calico CNI status

kubectl get pods -n kube-system

# example

root@ip-10-0-101-50:~# kubectl get pods -n kube-system
NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-65898446b5-gcdr4   1/1     Running   0          7m22s
calico-node-bts84                          1/1     Running   0          7m22s
calico-node-v8g8x                          1/1     Running   0          5m58s
coredns-78fcd69978-b6k98                   1/1     Running   0          109m
coredns-78fcd69978-fgx8r                   1/1     Running   0          109m
etcd-ip-10-0-101-50                        1/1     Running   0          109m
kube-apiserver-ip-10-0-101-50              1/1     Running   0          109m
kube-controller-manager-ip-10-0-101-50     1/1     Running   0          109m
kube-proxy-dnkhp                           1/1     Running   0          5m58s
kube-proxy-r6m7m                           1/1     Running   0          109m
kube-scheduler-ip-10-0-101-50              1/1     Running   0          109m

```







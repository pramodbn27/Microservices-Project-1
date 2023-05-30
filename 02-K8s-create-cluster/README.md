# k8scluster
create kubernetes cluster

## **Prequistes** 

### install eksctl on your work station

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin
```
### Check version 

```
eksctl version
```

### Install simple eks cluster with single worker node

```
cd eksctl/00-simple-cluster

eksctl create cluster -f cluster.yaml
```

#### The cluster build process will take around 15-20mins

### check in AWS console

```
Search for EKS > Clusters
```






# Create Cluster using eksctl

## Prerequite : install eksctl in laptop or workstation

```

# windows 

choco install eksctl

# mac

brew install eksctl

# Linux

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version
```

### install K8s cluster using eksctl

```
cd ${DIRECTORY}

eksctl create cluster -f ***.yml

```

## Access cluster using kubectl 

# create kubeconfig 

```

export KUBECONFIG=/<PATH>

aws eks update-kubeconfig --region region-code --name cluster-name

```

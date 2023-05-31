## install simple cluster 

``` 

cd  01-initial-cluster

eksctl apply -f cluster.yaml

```

### Things to define in the config file


``` yml

apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: eks-cluster         # name of the cluster
  region: us-east-1         # region you want the cluster to be installed
  version: "1.21"           # Version of the cluster

vpc:                        # if you want the cluster to deployed into a predefined VPC
  cidr: 10.0.0.0/16         # CIDR of the cluster

managedNodeGroups:          # Type of node
  - name: eks-node-group    # name of the Node
    instanceType: t2.medium # Type of EC2
    desiredCapacity: 1      # Number of nodes

```    

### More example 

https://github.com/weaveworks/eksctl/tree/main/examples
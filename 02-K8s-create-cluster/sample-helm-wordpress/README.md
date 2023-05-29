# Create Wordpress Site using Helm

### Install helm on our workstation (windows/mac/linux)

https://helm.sh/docs/intro/install/


### Add Helm repo in your workstation

```
helm repo add bitnami https://charts.bitnami.com/bitnami

#### Using NodePort to Avoid Creation of Load Balancer

helm install first-website bitnami/wordpress --set service.type=NodePort

```

### Check the Deployments, pods and svc which got created
```
kubectl get deploy
kubectl get pods
kubectl get svc
```

### Enable Caching for the sites ( check the Mirco service architecture)

```
helm upgrade -i my-website bitnami/wordpress --set service.type=NodePort,memcached.enabled=true,wordpressConfigureCache=true
```

### Login to the application by the output of the above command

## Note : ensure your cluster Node has Traffic allowed on Nodeport traffic from Internet



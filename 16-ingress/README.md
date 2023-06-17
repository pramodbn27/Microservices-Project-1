# Managing Access from Outside with K8s Ingress

## Relevant Documentation

#### Ingress

https://kubernetes.io/docs/concepts/services-networking/ingress/

#### Ingress Controllers

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

## Ingress controller with AWS

ref: https://kubernetes.github.io/ingress-nginx/deploy/#aws

***note*** : for other cloud provider see the above documentation

```
# Add helm repo 

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# install ingress controller

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/aws/deploy.yaml

```

#### The above will create ingress controller and service loadbalancer which mean it creates a network Load Balancer

```
kubectl get svc -n ingress-nginx
NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP                                                                     PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   10.100.194.106   XXX.elb.us-east-1.amazonaws.com   80:30968/TCP,443:32692/TCP   98s
ingress-nginx-controller-admission   ClusterIP      10.100.98.248    <none>                                                                          443/TCP                      98s

```


### Ingress using Nodeport for ALB

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace \
    --set controller.service.type=NodePort

kubectl get svc -n ingress-nginx


helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx --set controller.service.type=NodePort,controller.service.nodePorts.http=32500






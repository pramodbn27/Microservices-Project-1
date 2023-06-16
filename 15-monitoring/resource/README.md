# Inspecting Pod Resource Usage

## Relevant Documentation

#### Tools for Monitoring Resources 

https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/

#### kubectl cheat sheet

https://kubernetes.io/docs/reference/kubectl/cheatsheet/#interacting-with-running-pods

## Kubernetes Metrics Server

##### Inorder to view metrics about resources usage of our pods and containers, We need an add-on to collect and provide that data, and one such add on is Kubernetes Metrics server


#### install metrics server

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

```

#### Verify that the metrics-server deployment is running the desired number of pods with the following command.

```
kubectl get deployment metrics-server -n kube-system
```

#### Example output:

```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           6m

```

#### Once the metrics server is installed, deploy an app and monitor the usage of the pod

```
kubectl apply -f kube-manifests/myapp-deployment.yml
```

#### kubectl top
With kubectl top, you can view data about resource usage in your pods and nodes.
you can view data about also supports flags like and --sort-by and --selector

```
kubectl top pod --sort-by <JSONPATH> --selector <selector>

```

```
kubectl top pods

kubectl top pods --sort-by=cpu

kubectl top pods --selector app=myapp
```

## Managing container resources

### Relevant Documentation

#### Resource Requests and Limits

https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-requests-and-limits-of-pod-and-container

#### Resource requests

Resource requests allow you to define amount or resource ( CPU and Memory ) you expect the container to use.
The kubernetes scheduler will you resource requests to avoid scheduling the pods on nodes which do not have enough resources

**Note** : Resource request does not mean the container or pod cannot use more than requested resources, it is only used for scheduling

#### Resource Limits

Resource limits provide a way to limit the amount of resources your container can use, the kubelet enforces those limits so that the running container is not allowed to use more of that resource than the limit you set




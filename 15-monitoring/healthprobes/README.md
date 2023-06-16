# Monitoring Container Health with Probes

## Relevant Documentation

#### Pod Lifecycle

https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/

#### Container Probes

https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes


## Container Health

Kubernetes provides a number of features that allow us to build robust applications, and one of those features is the ability to automatically restart unhealthy containers.

So to make the most of these features,Kubernetes needs to be able to accurately determine the status of our applications.

Hence Health probes help us determine the state of the containers or the health of the containers.

### Liveness probe

Indicates whether the container is running. If the liveness probe fails, the kubelet kills the container, and the container is subjected to its restart policy. If a container does not provide a liveness probe, the default state is Success.

### readinessProbe

Indicates whether the container is ready to respond to requests. If the readiness probe fails, the endpoints controller removes the Pod's IP address from the endpoints of all Services that match the Pod. The default state of readiness before the initial delay is Failure. If a container does not provide a readiness probe, the default state is Success.

#### Check mechanisms

- exec
- httpGet
- tcpSocket

#### Probe outcome

- Success : The container passed the diagnostic.
- Failure : The container failed the diagnostic.
- Unknown : 



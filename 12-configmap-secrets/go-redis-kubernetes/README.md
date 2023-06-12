# Kubernetes Environment Variables & Configmap Examples using go application with redis cache

## Environment Variables

### Passing enviroment variables to the applications using env in container spec

```
# deploy the application, redis and services

kubectl apply -f deployments/env

# check the environment variables of redis host and port in go-app

kubectl exec -it <pod name> -- env

```

## Configmap Map as keys for enviroment variable

```
# deploy the application, redis and services

kubectl apply -f deployments/configmap

# check the environment variables of redis host and port in go-app

kubectl exec -it <pod name> -- env

# check the memory and memory policy of redis master pod

kubectl exec -it <redis-master-pod> -- redis-cli

# Check maxmemory:

127.0.0.1:6379> CONFIG GET maxmemory

# Check maxmemory-policy:

127.0.0.1:6379> CONFIG GET maxmemory-policy

```

## Configmap Map as keys for enviroment variable and multiple line confimap as mounted file

```
# deploy the application, redis and services

kubectl apply -f deployments/configmap-volume

# check the environment variables of redis host and port in go-app

kubectl exec -it <pod name> -- env

# check the configuration file which is mounted from configmap

kubectl exec -it <redis pod> -- ls /redis/redis.conf

kubectl exec -it <redis pod> -- cat /redis/redis.conf

# check memory parameter which were passed as configmap 

kubectl exec -it <redis-master-pod> -- redis-cli

# Check maxmemory:

127.0.0.1:6379> CONFIG GET maxmemory

# Check maxmemory-policy:

127.0.0.1:6379> CONFIG GET maxmemory-policy
```
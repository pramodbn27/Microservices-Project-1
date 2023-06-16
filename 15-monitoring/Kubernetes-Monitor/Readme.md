# Kubernetes Monitoring Using Prometheus Stack

> The Stack inludes the following

- Promethues
- Grafana
- Alert Manager

### Installing the Prometheus stack using Helm charts

**Ref : https://github.com/prometheus-community/helm-charts/**

#### Add the repo in your workstation

> Pre-requites :
- Kubernetes Cluster
- helm cli installed
- smtp server details if you need alert Manager configured


```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

```

#### Install the prometheus stack

> Since all the services are Cluster IP by default, modify the services to NodePort if you wanted to access the services using the cluster values file

**Values file**

```
prometheus:
  service:
    type: NodePort

grafana:
  service:
    type: NodePort

alertmanager:
  config:
    global:
      resolve_timeout: 5m
    route:
      group_wait: 20s
      group_interval: 4m
      repeat_interval: 4h
      receiver: 'email-k8s-admin'
      routes: []
    receivers:
    - name: 'email-k8s-admin'
      email_configs:
      - to: kiran@lwplabs.com
        from: kiran@lwplabs.com
        smarthost: smtp-relay.sendinblue.com:587
        auth_username: ********
        auth_password: ********
  service:
    type: NodePort
```

#### Install the chart

```
helm install prometheus prometheus-community/kube-prometheus-stack -f prometheus-values.yml
```

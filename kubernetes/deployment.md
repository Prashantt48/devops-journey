# Kubernetes Deployment

This directory contains Kubernetes deployment and service manifests for deploying an NGINX application.

## Files

- `deployment.yaml` - Creates an NGINX Deployment with 2 replicas.
- `service.yaml` - Exposes the NGINX application using a NodePort Service.
- `statefulset.yaml` - Example StatefulSet configuration for a stateful application.

---

## Kubernetes Deployment

A **Deployment** is used to manage stateless applications. It provides declarative updates for Pods and their associated ReplicaSets.

Deployments ensure that the desired number of Pod replicas are running and provide features such as scaling, rolling updates, and rollbacks.

### Key Features of Deployment

#### 1. Scalability

Deployments can scale the number of Pod replicas up or down based on application requirements.

#### 2. Rolling Updates

Deployments can update Pods gradually, helping maintain application availability during updates.

#### 3. Automatic Rollbacks

Deployments can roll back to a previous version if an update causes problems.

### Deployment Example

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

### Apply the Deployment

Save the configuration as `deployment.yaml` and run:

```bash
kubectl apply -f deployment.yaml
```

### Verify the Deployment

```bash
kubectl get deployments
kubectl get pods
kubectl get replicasets
```



# Kubernetes StatefulSet

A **StatefulSet** is used to manage stateful applications that require stable network identities and persistent storage.

StatefulSets are commonly used for applications such as databases, Redis, Kafka, and other systems where individual Pods need stable identities and storage.

## Key Features of StatefulSet

### 1. Stable Network Identity

Each Pod created by a StatefulSet receives a stable and predictable hostname.

For example:

```text
app-0
app-1
app-2
```

### 2. Persistent Storage

StatefulSets can create a PersistentVolumeClaim (PVC) for each Pod using `volumeClaimTemplates`.

This allows each Pod to have its own persistent storage.

### 3. Ordered Pod Creation and Deletion

By default, StatefulSet Pods are created and terminated in an ordered manner.

For example:

```text
app-0
app-1
app-2
```

The StatefulSet normally creates `app-0` before `app-1`, and `app-1` before `app-2`.

## StatefulSet Example

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: app
spec:
  serviceName: nginx
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

          volumeMounts:
            - name: www
              mountPath: /usr/share/nginx/html

  volumeClaimTemplates:
    - metadata:
        name: www
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 1Gi
```

### Apply the StatefulSet

Save the configuration as `statefulset.yaml` and run:

```bash
kubectl apply -f statefulset.yaml
```

### Verify the StatefulSet

```bash
kubectl get statefulsets
kubectl get pods
kubectl get pvc
```

---

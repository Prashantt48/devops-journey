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

---

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

# Deployment vs StatefulSet

| Feature | Deployment | StatefulSet |
|---|---|---|
| Application type | Stateless | Stateful |
| Pod identity | Random/generated | Stable and predictable |
| Pod names | Example: `nginx-abc123` | Example: `app-0`, `app-1` |
| Persistent storage | Optional | Commonly required |
| PVC management | Usually separate | Can use `volumeClaimTemplates` |
| Pod ordering | Not guaranteed | Ordered by default |
| Common use cases | Web applications, APIs | Databases, Redis, Kafka |
| Scaling | Easy | Supported with ordered behavior |
| Network identity | Not stable per Pod | Stable per Pod |

---

# Useful Kubernetes Commands

### Check all resources

```bash
kubectl get all
```

### Check Pods

```bash
kubectl get pods
```

### Check Deployments

```bash
kubectl get deployments
```

### Check StatefulSets

```bash
kubectl get statefulsets
```

### Check Services

```bash
kubectl get services
```

### Check PersistentVolumeClaims

```bash
kubectl get pvc
```

### Describe a Pod

```bash
kubectl describe pod <pod-name>
```

### View Pod logs

```bash
kubectl logs <pod-name>
```

---

# Deployment Architecture

```text
                 Kubernetes Cluster
                        |
                 +--------------+
                 |  Deployment  |
                 +--------------+
                        |
              +---------+---------+
              |                   |
          +-------+           +-------+
          | Pod 1 |           | Pod 2 |
          | NGINX |           | NGINX |
          +-------+           +-------+
              |
          ReplicaSet
```

# StatefulSet Architecture

```text
                 Kubernetes Cluster
                        |
                 +--------------+
                 | StatefulSet  |
                 +--------------+
                        |
          +-------------+-------------+
          |             |             |
       +------+       +------+      +------+
       | app-0|       | app-1|      | app-2|
       +------+       +------+      +------+
          |             |             |
        PVC-0         PVC-1         PVC-2
          |             |             |
        Storage       Storage       Storage
```

---

# Summary

- **Deployment** is primarily used for stateless applications.
- **StatefulSet** is primarily used for stateful applications.
- Deployment Pods do not have stable identities.
- StatefulSet Pods have stable and predictable identities.
- StatefulSets can provide persistent storage using PVCs.
- Deployments support rolling updates and rollbacks.
- StatefulSets are commonly used for databases, Redis, Kafka, and other stateful workloads.

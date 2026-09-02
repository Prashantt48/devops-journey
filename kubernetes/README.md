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


## Kubernetes ReplicaSet

A **ReplicaSet** in Kubernetes ensures that a specified number of identical **Pod replicas** are running at all times.

If a Pod fails, is deleted, or becomes unavailable, the ReplicaSet automatically creates a replacement Pod to maintain the desired number of replicas.

While ReplicaSets can be created directly, they are most commonly managed by **Deployments**, which provide rolling updates, version control, and rollback capabilities.

---

## Core Components of a ReplicaSet

A ReplicaSet consists of three important components:

### 1. Replicas

Defines the desired number of Pods that should be running.

Example:

```yaml
replicas: 3
```

### 2. Selector

The selector identifies the Pods managed by the ReplicaSet using labels.

Example:

```yaml
selector:
  matchLabels:
    tier: frontend
```

### 3. Template

The Pod template defines the configuration used to create new Pods.

---

## ReplicaSet Example

```yaml
apiVersion: apps/v1
kind: ReplicaSet

metadata:
  name: frontend

spec:
  replicas: 3

  selector:
    matchLabels:
      tier: frontend

  template:
    metadata:
      labels:
        tier: frontend

    spec:
      containers:
        - name: php-redis
          image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5
```

Save this configuration as:

```text
frontend.yaml
```

---

## ReplicaSet Commands

### Create ReplicaSet

```bash
kubectl apply -f frontend.yaml
```

### View ReplicaSets

```bash
kubectl get rs
```

### View ReplicaSets with additional information

```bash
kubectl get rs -o wide
```

### Describe ReplicaSet

```bash
kubectl describe rs frontend
```

### View Pods created by ReplicaSet

```bash
kubectl get pods
```

### Scale ReplicaSet

Increase the number of replicas to 5:

```bash
kubectl scale rs frontend --replicas=5
```

Verify:

```bash
kubectl get rs
kubectl get pods
```

### Delete ReplicaSet and its Pods

```bash
kubectl delete rs frontend
```

---

## Key Behaviors of ReplicaSet

### 1. Pod Acquisition

If a Pod does not have an owner and its labels match the ReplicaSet selector, the ReplicaSet can adopt that Pod.

For example:

```yaml
selector:
  matchLabels:
    tier: frontend
```

The Pod must have:

```yaml
labels:
  tier: frontend
```

---

### 2. Scaling

The number of Pods can be increased or decreased by changing:

```yaml
spec:
  replicas: 3
```

For example:

```yaml
spec:
  replicas: 5
```

You can also scale using the command line:

```bash
kubectl scale rs frontend --replicas=5
```

---

## Horizontal Pod Autoscaler

A ReplicaSet can also be scaled automatically using the **Horizontal Pod Autoscaler (HPA)**.

Example:

```bash
kubectl autoscale rs frontend --min=3 --max=10 --cpu-percent=50
```

This configures the ReplicaSet to maintain between **3 and 10 replicas** based on CPU utilization.

> Note: In modern Kubernetes environments, HPA is more commonly configured against a Deployment rather than directly against a ReplicaSet.

---

## 3. Pod Isolation

A Pod can be removed from ReplicaSet management by changing its labels so that they no longer match the ReplicaSet selector.

For example, if the ReplicaSet uses:

```yaml
selector:
  matchLabels:
    tier: frontend
```

Changing the Pod label from:

```yaml
tier: frontend
```

to:

```yaml
tier: backend
```

causes the Pod to no longer match the ReplicaSet selector.

The ReplicaSet may then create another Pod to maintain the desired replica count.

---

## 4. Deletion Policies

By default, deleting a ReplicaSet also deletes the Pods it manages.

To delete the ReplicaSet while keeping the Pods, use:

```bash
kubectl delete rs frontend --cascade=orphan
```

This deletes the ReplicaSet but leaves its Pods running.

---

## ReplicaSet vs Deployment

| Feature | ReplicaSet | Deployment |
|---|---|---|
| Maintains Pod replicas | Yes | Yes |
| Self-healing | Yes | Yes |
| Scaling | Yes | Yes |
| Rolling Updates | No | Yes |
| Rollbacks | No | Yes |
| Version Management | Limited | Yes |
| Manages ReplicaSets | No | Yes |
| Recommended for applications | Rarely | Yes |

### Relationship

A Deployment normally creates and manages a ReplicaSet.

```text
Deployment
     |
     v
ReplicaSet
     |
     +----------------+
     |       |        |
     v       v        v
   Pod-1   Pod-2    Pod-3
```

When you update a Deployment, Kubernetes typically creates a new ReplicaSet and gradually replaces Pods from the old ReplicaSet.

---

## When to Use ReplicaSet

Directly creating a ReplicaSet is uncommon.

Use a ReplicaSet directly when:

- You need custom update orchestration.
- You do not require rolling updates.
- You need basic Pod replication and self-healing.

For most production workloads, **prefer a Deployment** because it provides:

- Rolling updates
- Rollbacks
- Version management
- Scaling
- ReplicaSet management
- Declarative application updates

---

## Verify ReplicaSet

After applying the configuration:

```bash
kubectl apply -f frontend.yaml
```

Check the ReplicaSet:

```bash
kubectl get rs
```

Check the Pods:

```bash
kubectl get pods
```

Check detailed information:

```bash
kubectl describe rs frontend
```

---

## Summary

- A **ReplicaSet** maintains the desired number of Pod replicas.
- If a Pod fails or is deleted, the ReplicaSet creates a replacement.
- `replicas` defines the desired Pod count.
- `selector` determines which Pods the ReplicaSet manages.
- `template` defines how new Pods are created.
- ReplicaSets support scaling.
- ReplicaSets can be used with Horizontal Pod Autoscaler.
- Deployments normally manage ReplicaSets automatically.
- **Deployment is recommended over directly managing ReplicaSets for most applications.**

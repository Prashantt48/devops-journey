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

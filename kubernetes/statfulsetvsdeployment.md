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


# Kubernetes Health Probes

Kubernetes health probes are checks used to determine the health and availability of containers.

There are three important types of probes:

1. **Liveness Probe**
2. **Readiness Probe**
3. **Startup Probe**

---

## 1. Liveness Probe

A **liveness probe** checks whether a container is still running properly and able to make progress.

If the liveness probe fails repeatedly, Kubernetes restarts the container.

### Why Use Liveness Probe?

Liveness probes help recover applications from problems such as:

- Deadlocks
- Infinite loops
- Application hangs
- Unresponsive processes
- Internal application failures

### How Liveness Probe Works

```text
Kubernetes
    |
    |--- Liveness Check
    |
    v
Container
    |
    +-- Healthy ------> Continue Running
    |
    +-- Unhealthy ----> Restart Container
```

### Types of Liveness Probes

Kubernetes supports several mechanisms:

- HTTP GET
- TCP Socket
- Command (`exec`)
- gRPC

### HTTP Liveness Probe Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-demo
spec:
  containers:
    - name: nginx
      image: nginx:latest
      livenessProbe:
        httpGet:
          path: /
          port: 80
        initialDelaySeconds: 10
        periodSeconds: 10
        timeoutSeconds: 2
        failureThreshold: 3
```

### Important Parameters

| Parameter | Description |
|---|---|
| `initialDelaySeconds` | Time to wait before the first probe |
| `periodSeconds` | How frequently the probe runs |
| `timeoutSeconds` | Maximum time allowed for a probe response |
| `failureThreshold` | Number of consecutive failures before the action is taken |
| `successThreshold` | Number of successful checks required |

### Important Point

A liveness probe should check whether the application itself is functioning.

Avoid making the liveness probe depend on external services such as databases unless that behavior is intentionally required. Otherwise, a temporary database problem could cause unnecessary container restarts.

---

# 2. Readiness Probe

A **readiness probe** determines whether a container is ready to receive traffic.

If the readiness probe fails, Kubernetes removes the Pod from the endpoints used for Service traffic.

The container is **not necessarily restarted**.

### Why Use Readiness Probe?

Readiness probes are useful when:

- The application is still initializing
- The application temporarily cannot serve requests
- A required dependency is unavailable
- The application is overloaded
- The application needs to stop receiving traffic during maintenance

### How Readiness Probe Works

```text
                 Readiness Probe
                       |
                       v
                 +-----------+
                 |   Pod     |
                 +-----------+
                  /         \
             Ready          Not Ready
                |               |
                v               v
        Receive Traffic    No Service Traffic
```

### HTTP Readiness Probe Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-demo
spec:
  containers:
    - name: nginx
      image: nginx:latest
      readinessProbe:
        httpGet:
          path: /
          port: 80
        initialDelaySeconds: 5
        periodSeconds: 5
        timeoutSeconds: 2
        failureThreshold: 3
```

### Important Point

A failed readiness probe does **not** normally restart the container.

Instead, the Pod is marked as **NotReady**, so Kubernetes stops sending Service traffic to it.

---

# 3. Startup Probe

A **startup probe** determines whether an application has successfully started.

Startup probes are particularly useful for applications that require a long time to initialize.

Examples include:

- Applications loading large datasets
- Applications performing migrations
- Java applications with slow startup
- Applications with lengthy initialization processes

### How Startup Probe Works

When a startup probe is configured:

```text
Pod Starts
    |
    v
Startup Probe
    |
    +---- Failed ----> Continue Startup Checking
    |
    +---- Successful
              |
              v
      Liveness/Readiness
          Probes Start
```

Until the startup probe succeeds, Kubernetes does not run the liveness and readiness probes for that container.

This prevents a slow-starting application from being restarted by its liveness probe before it has finished starting.

### Startup Probe Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: startup-demo
spec:
  containers:
    - name: app
      image: nginx:latest
      startupProbe:
        httpGet:
          path: /
          port: 80
        failureThreshold: 30
        periodSeconds: 10

      livenessProbe:
        httpGet:
          path: /
          port: 80
        periodSeconds: 10

      readinessProbe:
        httpGet:
          path: /
          port: 80
        periodSeconds: 5
```

In this example, the startup probe can allow approximately:

```text
30 failures × 10 seconds = 300 seconds
```

for the application to start before Kubernetes considers the startup check unsuccessful.

---

# Liveness vs Readiness vs Startup

| Probe | Purpose | Failure Result |
|---|---|---|
| **Liveness** | Checks whether the container is functioning | Container may be restarted |
| **Readiness** | Checks whether the Pod can receive traffic | Pod removed from Service endpoints |
| **Startup** | Checks whether the application has started | Liveness and readiness probes wait |

---

# Simple Real-World Example

Consider an application deployed with 3 Pods:

```text
                 Kubernetes Service
                        |
             +----------+----------+
             |          |          |
             v          v          v
           Pod-1      Pod-2      Pod-3
            |          |          |
          Ready      Ready     Not Ready
            |          |          |
          Traffic    Traffic   No Traffic
```

Suppose Pod-3 has an application problem.

Its readiness probe fails:

```text
Pod-3
  |
  +-- Readiness Probe Failed
  |
  v
NotReady
  |
  v
Service stops routing traffic to Pod-3
```

If the application is completely stuck and its liveness probe fails:

```text
Pod-3
  |
  +-- Liveness Probe Failed
  |
  v
Container Restart
```

If the application takes a long time to start:

```text
Pod starts
   |
   v
Startup Probe
   |
   v
Application initializes
   |
   v
Startup Probe succeeds
   |
   +------------------+
   |                  |
   v                  v
Liveness Probe    Readiness Probe
```

---

# Probe Types

## HTTP GET

Checks an HTTP endpoint.

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
```

Useful for web applications and APIs.

---

## TCP Socket

Checks whether a TCP connection can be established.

```yaml
livenessProbe:
  tcpSocket:
    port: 8080
```

Useful when an application exposes a TCP port but does not provide an HTTP health endpoint.

---

## Command / Exec

Runs a command inside the container.

```yaml
livenessProbe:
  exec:
    command:
      - cat
      - /tmp/healthy
```

If the command exits successfully, the probe succeeds.

---

## gRPC

Kubernetes also supports gRPC health checking for applications that expose a suitable gRPC health endpoint.

Example:

```yaml
livenessProbe:
  grpc:
    port: 50051
```

---

# Complete Example

The following example uses all three probes:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: probe-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: probe-demo
  template:
    metadata:
      labels:
        app: probe-demo
    spec:
      containers:
        - name: app
          image: nginx:latest
          ports:
            - containerPort: 80

          startupProbe:
            httpGet:
              path: /
              port: 80
            failureThreshold: 30
            periodSeconds: 10

          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 10
            timeoutSeconds: 2
            failureThreshold: 3

          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 2
            failureThreshold: 3
```

---

# Useful Kubernetes Commands

### Create the Deployment

```bash
kubectl apply -f probe-demo.yaml
```

### Check Pods

```bash
kubectl get pods
```

### Check Pod Details

```bash
kubectl describe pod <pod-name>
```

### Check Deployment

```bash
kubectl get deployment
```

### Check Pod Events

```bash
kubectl describe pod <pod-name>
```

### Check Logs

```bash
kubectl logs <pod-name>
```

### Follow Logs

```bash
kubectl logs -f <pod-name>
```

### Check Pod Status

```bash
kubectl get pods -o wide
```

---

# Common Troubleshooting

## 1. Pod Keeps Restarting

Check:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

Look for:

```text
Liveness probe failed
```

Possible causes:

- Incorrect health-check path
- Incorrect port
- Application is slow
- Application is unhealthy
- Probe timeout is too short
- Failure threshold is too low

---

## 2. Pod is Running but Not Ready

Check:

```bash
kubectl get pods
kubectl describe pod <pod-name>
```

You may see:

```text
Readiness probe failed
```

Possible causes:

- Application is still initializing
- Wrong readiness endpoint
- Wrong port
- Application cannot access a required dependency
- Health endpoint is returning an error

---

## 3. Application Takes Too Long to Start

Use a startup probe.

Example:

```yaml
startupProbe:
  httpGet:
    path: /health
    port: 8080
  failureThreshold: 30
  periodSeconds: 10
```

This gives the application time to start before liveness checking takes over.

---

# Best Practices

1. Use **liveness** to detect applications that are stuck or unhealthy.
2. Use **readiness** to control whether a Pod receives traffic.
3. Use **startup** for slow-starting applications.
4. Do not make liveness checks unnecessarily dependent on external services.
5. Make sure probe ports and paths are correct.
6. Give slow applications enough startup time.
7. Avoid overly aggressive probe settings.
8. Test health endpoints before deploying probes.
9. Monitor probe failures in production.
10. Use realistic `timeoutSeconds`, `periodSeconds`, and `failureThreshold` values.

---

# Interview Questions

## Q1. What is a liveness probe?

A liveness probe checks whether a container is still functioning. If it repeatedly fails, Kubernetes can restart the container.

---

## Q2. What is a readiness probe?

A readiness probe checks whether a Pod is ready to receive traffic. If it fails, the Pod is removed from the Service endpoints until it becomes ready again.

---

## Q3. What is a startup probe?

A startup probe checks whether an application has successfully started. Until it succeeds, Kubernetes does not run the liveness and readiness probes for that container.

---

## Q4. What happens when a liveness probe fails?

Kubernetes restarts the affected container after the configured failure conditions are met.

---

## Q5. What happens when a readiness probe fails?

The Pod is marked as NotReady and is removed from the Service endpoints used for traffic routing. The container is not automatically restarted just because readiness failed.

---

## Q6. Why do we need a startup probe?

A startup probe protects slow-starting applications from being restarted too early by the liveness probe.

---

## Q7. What are the common probe mechanisms?

The common mechanisms are:

- HTTP GET
- TCP Socket
- Exec
- gRPC

---

## Q8. What is the difference between liveness and readiness?

```text
Liveness  → Is the application alive?
Readiness → Can the application receive traffic?
```

---

## Q9. What is the difference between startup and liveness?

```text
Startup  → Has the application started?
Liveness → Is the running application still healthy?
```

---

## Q10. Can liveness and readiness probes use the same endpoint?

Yes. They can use the same endpoint when that endpoint correctly represents both application health and traffic readiness.

However, in real production applications, separate endpoints are often useful because **being alive** and **being ready to serve traffic** can represent different conditions.

---

# Quick Revision

```text
Liveness
   ↓
Container is alive?
   ↓
NO → Restart container

Readiness
   ↓
Pod ready for traffic?
   ↓
NO → Remove from Service endpoints

Startup
   ↓
Application started?
   ↓
NO → Keep checking startup
YES
   ↓
Enable liveness/readiness checking
```

---

# Summary

| Probe | Main Question | Action on Failure |
|---|---|---|
| Liveness | Is the container healthy/alive? | Restart container |
| Readiness | Can the Pod serve traffic? | Stop routing traffic to Pod |
| Startup | Has the application started? | Wait and keep checking |

**Easy way to remember:**

```text
Startup   → "Has it started?"
Readiness → "Can it receive traffic?"
Liveness  → "Is it still alive?"
```

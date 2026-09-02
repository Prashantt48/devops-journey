# Kubernetes ConfigMaps

## What is a ConfigMap?

A **ConfigMap** stores non-sensitive configuration data in key-value pairs, separate from application code.

ConfigMaps help make applications portable and easier to manage across different environments.

Common examples of configuration data include:

- Database hostnames
- URLs
- Application settings
- Debug settings
- Log levels

ConfigMaps can be consumed by Pods as:

- Environment variables
- Command-line arguments
- Mounted configuration files

> **Note:** ConfigMaps should not be used for sensitive information. Use Kubernetes **Secrets** for passwords, API keys, tokens, and other confidential data.

---

# ConfigMap Example

For example, an application might use:

```text
Local Environment:
DATABASE_HOST=localhost

Cloud Environment:
DATABASE_HOST=my-service
```

Instead of hardcoding these values into the application, they can be stored in a ConfigMap.

---

# Creating a ConfigMap

There are two common approaches:

1. Imperative approach using `kubectl`
2. Declarative approach using a YAML manifest

---

## 1. Create ConfigMap Using kubectl

### From Literal Values

```bash
kubectl create configmap demo-config \
  --from-literal=database_host=172.138.0.1 \
  --from-literal=debug_mode=1 \
  --from-literal=log_level=verbose
```

Verify:

```bash
kubectl get configmap
```

---

### From a File

A ConfigMap can also be created from an existing configuration file.

```bash
kubectl create configmap demo-config \
  --from-file=config.properties
```

---

# 2. Create ConfigMap Using YAML

Create a file:

```bash
vim config.yaml
```

Example:

```yaml
apiVersion: v1
kind: ConfigMap

metadata:
  name: demo-config

data:
  database_host: "172.138.0.1"
  debug_mode: "1"
  log_level: "verbose"
```

Apply the ConfigMap:

```bash
kubectl apply -f config.yaml
```

Verify:

```bash
kubectl get configmap
```

---

# ConfigMap Data

ConfigMap configuration is normally stored under the `data` field.

Example:

```yaml
data:
  database_host: "172.138.0.1"
  debug_mode: "1"
  log_level: "verbose"
```

The values under `data` are strings.

---

# ConfigMap binaryData

For binary data, Kubernetes ConfigMaps can use the `binaryData` field.

Example:

```yaml
apiVersion: v1
kind: ConfigMap

metadata:
  name: binary-config

data:
  text-data: "This is a string value"

binaryData:
  binary-file: |
    U29tZSBiaW5hcnkgZGF0YQ==
```

The `data` field contains string values, while `binaryData` can contain binary data represented using base64 encoding.

---

# Viewing ConfigMaps

## List ConfigMaps

```bash
kubectl get configmaps
```

or:

```bash
kubectl get cm
```

---

## Describe a ConfigMap

```bash
kubectl describe configmap <configmap-name>
```

Example:

```bash
kubectl describe configmap demo-config
```

This displays information about the ConfigMap, including its configuration data.

---

## Get ConfigMap YAML

```bash
kubectl get configmap demo-config -o yaml
```

---

## Get ConfigMap Data as JSON

```bash
kubectl get configmap <configmap-name> \
  -o=jsonpath='{.data}' | jq
```

Example:

```bash
kubectl get configmap demo-config \
  -o=jsonpath='{.data}' | jq
```

---

# Using ConfigMap in Pods

ConfigMaps can be consumed by Pods in different ways.

Common methods include:

- Environment variables
- Volume mounts
- Configuration files
- Command-line arguments

---

# Mount ConfigMap as a Volume

First create a ConfigMap.

Then mount it into a Pod as a volume.

Example:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: my-pod

spec:
  containers:
    - name: my-container
      image: my-image

      volumeMounts:
        - name: configmap-volume
          mountPath: /etc/configmap

  volumes:
    - name: configmap-volume
      configMap:
        name: my-configmap
```

The ConfigMap named `my-configmap` is mounted inside the container at:

```text
/etc/configmap
```

---

# Access ConfigMap Files Inside a Pod

List the mounted files:

```bash
ls /etc/configmap
```

Read a configuration file:

```bash
cat /etc/configmap/my-file.txt
```

Architecture:

```text
ConfigMap
    |
    v
Kubernetes Volume
    |
    v
Pod
    |
    v
/etc/configmap/
```

---

# ConfigMap as Environment Variables

A ConfigMap can also be used to provide environment variables to a container.

Example:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: configmap-env-pod

spec:
  containers:
    - name: app
      image: nginx

      env:
        - name: DATABASE_HOST
          valueFrom:
            configMapKeyRef:
              name: demo-config
              key: database_host

        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: demo-config
              key: log_level
```

Inside the container:

```bash
echo $DATABASE_HOST
echo $LOG_LEVEL
```

---

# ConfigMap as Command-Line Configuration

A ConfigMap can be mounted as a file and the application can use that file as a command-line argument.

Example:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: test-pod

spec:
  containers:
    - name: test-container
      image: my-app-image

      command:
        - /bin/sh
        - -c
        - "your-app-binary --config /mnt/test-config/config.properties"

      volumeMounts:
        - name: config-volume
          mountPath: /mnt/test-config

  volumes:
    - name: config-volume
      configMap:
        name: test-config
```

Architecture:

```text
ConfigMap
    |
    v
Volume Mount
    |
    v
/mnt/test-config/config.properties
    |
    v
Application
```

---

# ConfigMaps Stored in Kubernetes

ConfigMaps are stored as Kubernetes API objects in the cluster's **etcd** datastore.

They are managed through the Kubernetes API Server.

They can be accessed using:

```bash
kubectl
```

or through the Kubernetes API.

Architecture:

```text
kubectl
   |
   v
API Server
   |
   v
etcd
   |
   v
ConfigMap
```

---

# Immutable ConfigMap

An **immutable ConfigMap** prevents changes to the ConfigMap after it has been created.

Immutable ConfigMaps can help maintain consistent configuration and prevent accidental modifications.

Example:

```yaml
apiVersion: v1
kind: ConfigMap

metadata:
  name: test-config

data:
  config.properties: |
    database_url=http://example.com/db
    debug_mode=true
    log_level=debug

immutable: true
```

Apply:

```bash
kubectl apply -f test-config.yaml
```

Once immutable, the ConfigMap data cannot be modified.

If the configuration needs to change:

```text
Old ConfigMap
      |
      X
 Cannot modify
      |
      v
Create New ConfigMap
      |
      v
Update Pods
```

---

# Updating ConfigMaps

A ConfigMap can be edited using:

```bash
kubectl edit configmap <configmap-name>
```

Example:

```bash
kubectl edit configmap demo-config
```

You can also update a ConfigMap using declarative YAML:

```bash
kubectl apply -f config.yaml
```

> **Important:** When a ConfigMap is updated, Pods using the ConfigMap as environment variables are not automatically restarted. Applications may therefore continue using the previous environment-variable values until the Pod is recreated.

---

# ConfigMap Best Practices

## 1. Use ConfigMaps for Non-Sensitive Data

Do not store:

- Passwords
- API keys
- Private keys
- Tokens
- Other confidential information

Use **Secrets** for sensitive information.

---

## 2. Keep ConfigMaps Small

ConfigMaps have a size limit. For large configuration files or datasets, consider using appropriate storage such as volumes.

---

## 3. Use Immutable ConfigMaps When Appropriate

Immutable ConfigMaps can help prevent accidental configuration changes.

---

## 4. Use Clear Names

Use descriptive names that indicate the purpose of the ConfigMap.

Examples:

```text
dev-db-config
prod-db-config
application-config
nginx-config
```

---

## 5. Version Configuration

For important production configuration changes, consider creating a new versioned ConfigMap and updating workloads to use it.

Example:

```text
app-config-v1
app-config-v2
app-config-v3
```

---

## 6. Monitor Configuration Changes

Plan how applications will consume configuration updates.

Pods using ConfigMaps as environment variables do not automatically restart when the ConfigMap changes.

---

# ConfigMap vs Secret

| Feature | ConfigMap | Secret |
|---|---|---|
| Purpose | Non-sensitive configuration | Sensitive information |
| Examples | URLs, hostnames, settings | Passwords, tokens, certificates |
| Environment Variables | Yes | Yes |
| Volume Mount | Yes | Yes |
| Sensitive Data | No | Yes |
| RBAC | Supported | Supported |
| Kubernetes Object | Yes | Yes |

Example:

```text
ConfigMap
    |
    +-- Database hostname
    +-- Application URL
    +-- Log level
    +-- Debug setting


Secret
    |
    +-- Database password
    +-- API token
    +-- TLS private key
```

---

# Useful ConfigMap Commands

### Create ConfigMap

```bash
kubectl create configmap demo-config \
  --from-literal=key1=value1
```

### Create from file

```bash
kubectl create configmap demo-config \
  --from-file=config.properties
```

### Apply YAML

```bash
kubectl apply -f config.yaml
```

### List ConfigMaps

```bash
kubectl get configmaps
```

### Describe ConfigMap

```bash
kubectl describe configmap demo-config
```

### Get YAML

```bash
kubectl get configmap demo-config -o yaml
```

### Edit ConfigMap

```bash
kubectl edit configmap demo-config
```

### Delete ConfigMap

```bash
kubectl delete configmap demo-config
```

---

# Interview Questions

## What is a ConfigMap?

**Answer:**

> A ConfigMap is a Kubernetes object used to store non-sensitive configuration data separately from application code. It can be consumed by Pods through environment variables, command-line arguments, or mounted configuration files.

---

## What is the difference between ConfigMap and Secret?

**Answer:**

> ConfigMap is intended for non-sensitive configuration data such as URLs, hostnames, and application settings. Secrets are intended for sensitive information such as passwords, tokens, and certificates.

---

## How can you create a ConfigMap?

Using `kubectl`:

```bash
kubectl create configmap demo-config \
  --from-literal=key=value
```

Or using YAML:

```bash
kubectl apply -f config.yaml
```

---

## How can a Pod consume a ConfigMap?

A Pod can consume a ConfigMap through:

1. Environment variables
2. Volume mounts
3. Configuration files
4. Command-line arguments

---

## How do you check a ConfigMap?

```bash
kubectl get configmap
```

or:

```bash
kubectl describe configmap <configmap-name>
```

---

## What is an Immutable ConfigMap?

**Answer:**

> An immutable ConfigMap is a ConfigMap that cannot be modified after creation. It can help prevent accidental configuration changes and maintain configuration consistency.

---

# Summary

A Kubernetes ConfigMap provides a way to separate application configuration from application code.

Key points:

- Stores non-sensitive configuration.
- Uses key-value pairs.
- Can be created using `kubectl` or YAML.
- Can be consumed as environment variables.
- Can be mounted as files.
- Can be used for command-line configuration.
- Is stored as a Kubernetes API object.
- Can be made immutable.
- Should not be used for passwords or other sensitive data.
- Secrets should be used for sensitive information.

```text
                Kubernetes
                    |
              +-----+-----+
              |           |
              v           v
          ConfigMap      Secret
              |           |
              v           v
       Non-sensitive    Sensitive
       configuration    information
              |           |
              +-----+-----+
                    |
                    v
                   Pod
```

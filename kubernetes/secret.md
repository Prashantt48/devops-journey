# Kubernetes Secrets

In Kubernetes, **Secrets** are objects designed to store sensitive data such as passwords, tokens, API keys, and other credentials.

Secrets help avoid embedding confidential information directly into application code or Pod specifications.

Secrets are similar to **ConfigMaps**, but Secrets are specifically intended for sensitive information.

---

## Key Features of Kubernetes Secrets

### 1. Base64 Encoding

Kubernetes Secret values are stored as Base64-encoded data when using the `data` field.

> **Important:** Base64 encoding is **not encryption**. Anyone who can read the Secret may decode the value.

Example:

```bash
echo -n "admin" | base64
```

Output:

```text
YWRtaW4=
```

To decode:

```bash
echo -n "YWRtaW4=" | base64 --decode
```

Output:

```text
admin
```

### 2. Encryption at Rest

Kubernetes can be configured to encrypt Secrets when they are stored in **etcd**.

Encryption at rest helps protect Secret data if the underlying etcd data is accessed.

### 3. RBAC Integration

Kubernetes integrates Secrets with **Role-Based Access Control (RBAC)**.

RBAC can be used to restrict which users, groups, or ServiceAccounts can access Secrets.

### 4. Namespace Isolation

Secrets are namespace-scoped objects.

For example:

```text
Namespace: production
    |
    +-- db-secret
    +-- api-secret

Namespace: development
    |
    +-- db-secret
```

A Secret in one namespace is not automatically available in another namespace.

---

# Common Use Cases

Kubernetes Secrets are commonly used for:

- Database usernames and passwords
- API keys
- Authentication tokens
- TLS certificates
- SSH private keys
- Private container registry credentials
- Application credentials

---

# Types of Kubernetes Secrets

Kubernetes provides several built-in Secret types.

| Secret Type | Purpose |
|---|---|
| `Opaque` | Default type for arbitrary user-defined data |
| `kubernetes.io/service-account-token` | ServiceAccount token |
| `kubernetes.io/dockerconfigjson` | Docker/container registry credentials |
| `kubernetes.io/basic-auth` | Basic authentication credentials |
| `kubernetes.io/ssh-auth` | SSH private key |
| `kubernetes.io/tls` | TLS certificate and private key |

---

# Creating Kubernetes Secrets

There are several ways to create a Secret.

## 1. Create Secret Using kubectl

Example:

```bash
kubectl create secret generic my-secret \
  --from-literal=username=admin \
  --from-literal=password=secretpassword
```

Verify:

```bash
kubectl get secrets
```

Describe the Secret:

```bash
kubectl describe secret my-secret
```

> `kubectl describe secret` does not display the Secret values directly.

---

# 2. Create Secret Using YAML

Example:

```yaml
apiVersion: v1
kind: Secret

metadata:
  name: my-secret

type: Opaque

data:
  username: YWRtaW4=
  password: cGFzc3dvcmQ=
```

Save the file as:

```text
secret.yaml
```

Apply it:

```bash
kubectl apply -f secret.yaml
```

Verify:

```bash
kubectl get secret my-secret
```

View the encoded data:

```bash
kubectl get secret my-secret -o yaml
```

---

# Creating Base64 Values

For example, to encode a username:

```bash
echo -n "admin" | base64
```

Output:

```text
YWRtaW4=
```

Encode a password:

```bash
echo -n "password" | base64
```

Output:

```text
cGFzc3dvcmQ=
```

These encoded values can then be used in the Secret YAML.

---

# Using Secrets in Pods

Secrets can be consumed by Pods mainly in two ways:

1. Environment Variables
2. Volume Mounts

---

# 1. Using Secrets as Environment Variables

Example:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: secret-demo

spec:
  containers:
    - name: nginx
      image: nginx:latest

      env:
        - name: DB_USERNAME
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: username

        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: my-secret
              key: password
```

The container receives:

```text
DB_USERNAME
DB_PASSWORD
```

as environment variables.

---

# 2. Using Secrets as Volume Mounts

Secrets can also be mounted as files inside a container.

Example:

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: secret-volume-demo

spec:
  containers:
    - name: nginx
      image: nginx:latest

      volumeMounts:
        - name: secret-volume
          mountPath: /etc/secrets
          readOnly: true

  volumes:
    - name: secret-volume
      secret:
        secretName: my-secret
```

The Secret values will be available as files under:

```text
/etc/secrets/
```

For example:

```text
/etc/secrets/username
/etc/secrets/password
```

---

# Useful Secret Commands

### List Secrets

```bash
kubectl get secrets
```

### Get a Specific Secret

```bash
kubectl get secret my-secret
```

### Describe a Secret

```bash
kubectl describe secret my-secret
```

### View Secret YAML

```bash
kubectl get secret my-secret -o yaml
```

### Decode a Secret Value

```bash
kubectl get secret my-secret \
  -o jsonpath='{.data.password}' | base64 --decode
```

### Delete a Secret

```bash
kubectl delete secret my-secret
```

---

# Immutable Secrets

Kubernetes supports immutable Secrets.

An immutable Secret cannot be changed after creation.

Example:

```yaml
apiVersion: v1
kind: Secret

metadata:
  name: immutable-secret

type: Opaque

immutable: true

data:
  username: YWRtaW4=
```

Benefits include:

- Prevents accidental modification.
- Improves protection against unwanted updates.
- Useful for configuration that should remain unchanged.

---

# Security Best Practices

## 1. Enable Encryption at Rest

Enable encryption for Secrets stored in etcd.

```text
Pod
 |
 v
Kubernetes API Server
 |
 v
Encrypted Secret
 |
 v
etcd
```

---

## 2. Use RBAC

Follow the **principle of least privilege**.

Give users and applications only the permissions they actually need.

For example:

```yaml
rules:
  - apiGroups:
      - ""
    resources:
      - secrets
    verbs:
      - get
```

Avoid giving unnecessary permissions such as:

```text
secrets:
  *
```

---

## 3. Use Namespace Isolation

Keep Secrets separated between environments.

Example:

```text
development
    |
    +-- db-secret

testing
    |
    +-- db-secret

production
    |
    +-- db-secret
```

---

## 4. Rotate Secrets Regularly

Passwords, API keys, and tokens should be rotated periodically.

Example:

```text
Old Password
     |
     v
Rotate Secret
     |
     v
New Password
     |
     v
Restart/Refresh Application if required
```

---

## 5. Avoid Storing Plaintext Secrets in Git

Do **not** commit real passwords, API keys, or tokens directly into Git repositories.

Avoid:

```yaml
password: MyRealPassword123
```

Use appropriate secret-management solutions for production environments.

---

# Secret Architecture

```text
                    Kubernetes Cluster
                           |
                    +--------------+
                    |     Secret   |
                    +--------------+
                           |
             +-------------+-------------+
             |                           |
             v                           v
      Environment Variable          Volume Mount
             |                           |
             v                           v
        Application                  Secret File
             |                           |
             +-------------+-------------+
                           |
                         Pod
```

---

# Secret vs ConfigMap

| Feature | Secret | ConfigMap |
|---|---|---|
| Intended for sensitive data | Yes | No |
| Passwords | Yes | No |
| API keys | Yes | No |
| Configuration values | Sometimes | Yes |
| Base64 `data` field | Yes | No |
| Encryption at rest | Supported | Supported depending on setup |
| RBAC | Yes | Yes |
| Namespace scoped | Yes | Yes |

---

# Important Security Note

**Base64 encoding is not encryption.**

For example:

```text
secretpassword
      |
      v
Base64 encoding
      |
      v
c2VjcmV0cGFzc3dvcmQ=
```

Anyone who has access to the encoded value can decode it.

For production environments, use:

- Kubernetes encryption at rest
- RBAC
- Namespace isolation
- Secret rotation
- External secret-management solutions where appropriate

---

# Summary

- **Secret** is a Kubernetes object used to store sensitive information.
- Secrets can contain passwords, tokens, API keys, certificates, and credentials.
- Secrets can be consumed through environment variables or mounted as files.
- Secrets are namespace-scoped.
- RBAC should be used to restrict access.
- Encryption at rest should be enabled for production environments.
- Base64 encoding is **not encryption**.
- Secrets should not contain real credentials in Git repositories.
- Secrets can be made immutable.
- Regular Secret rotation improves security.

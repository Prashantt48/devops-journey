# NGINX

## What is NGINX?

**NGINX** (pronounced **engine-x**) is an open-source, high-performance web server that can also function as a:

- Web server
- Reverse proxy
- HTTP cache
- Load balancer
- TCP/UDP proxy

NGINX is widely used for serving web applications, handling high volumes of concurrent connections, load balancing backend servers, and acting as a reverse proxy.

---

# Key Capabilities of NGINX

## 1. Web Server

NGINX can serve static content such as:

- HTML files
- CSS files
- JavaScript files
- Images
- Videos

Example:

```text
Client
   |
   v
NGINX
   |
   v
Static Files
```

---

## 2. Reverse Proxy

NGINX can act as a reverse proxy between clients and backend application servers.

```text
Client
   |
   v
 NGINX
   |
   +----------+----------+
   |          |          |
   v          v          v
Backend-1  Backend-2  Backend-3
```

Benefits include:

- Hiding backend servers
- Load balancing
- SSL/TLS termination
- Request routing
- Improved security
- Centralized access logging

---

## 3. Load Balancing

NGINX can distribute client requests across multiple backend servers.

```text
                  NGINX
               Load Balancer
                    |
          +---------+---------+
          |         |         |
          v         v         v
       Server-1  Server-2  Server-3
```

Common load-balancing methods include:

- Round Robin
- Least Connections
- IP Hash
- Generic Hash
- Random

---

## 4. HTTP Caching

NGINX can cache frequently requested content.

```text
Client
   |
   v
NGINX Cache
   |
   +---- Cache Hit ----> Response
   |
   +---- Cache Miss ---> Backend
```

Caching can reduce backend load and improve response time.

---

## 5. Protocol Support

NGINX supports various protocols and technologies, including:

- HTTP/1.1
- HTTP/2
- HTTP/3
- WebSockets
- TLS/SSL
- SNI
- TCP
- UDP

---

## 6. Mail Proxy

NGINX can also act as a proxy for mail protocols such as:

- IMAP
- POP3
- SMTP

---

## 7. TCP/UDP Proxy

NGINX can proxy generic TCP and UDP traffic.

This capability is useful when NGINX needs to handle non-HTTP workloads.

---

# NGINX Architecture

NGINX uses a **master-worker process model**.

```text
                 NGINX
                   |
             Master Process
                   |
        +----------+----------+
        |          |          |
        v          v          v
     Worker-1   Worker-2   Worker-3
        |          |          |
        +----------+----------+
                   |
              Client Requests
```

---

## Master Process

The master process is responsible for:

- Reading and validating configuration
- Managing worker processes
- Starting worker processes
- Stopping worker processes
- Handling configuration reloads
- Managing graceful upgrades

---

## Worker Processes

Worker processes handle client requests.

NGINX uses an **event-driven and non-blocking architecture**, allowing workers to handle many concurrent connections efficiently.

This design helps NGINX provide:

- High concurrency
- Low memory overhead
- Efficient connection handling
- High performance

---

# NGINX Configuration

The main NGINX configuration file on Ubuntu is commonly:

```text
/etc/nginx/nginx.conf
```

NGINX can also use configuration files under:

```text
/etc/nginx/conf.d/
```

and, on Debian/Ubuntu systems:

```text
/etc/nginx/sites-available/
```

```text
/etc/nginx/sites-enabled/
```

---

# Basic NGINX Configuration

Example:

```nginx
server {
    listen 80;

    server_name example.com;

    location / {
        root /var/www/html;
        index index.html;
    }
}
```

This configuration:

- Listens on port `80`
- Responds to requests for `example.com`
- Serves files from `/var/www/html`
- Uses `index.html` as the default page

---

# NGINX as Reverse Proxy

Example configuration:

```nginx
server {
    listen 80;

    server_name example.com;

    location / {
        proxy_pass http://backend:8080;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Architecture:

```text
Client
  |
  | HTTP Request
  v
NGINX :80
  |
  | proxy_pass
  v
Backend Application :8080
```

---

# NGINX Load Balancing Example

Define an upstream group:

```nginx
upstream backend_servers {
    server backend1:8080;
    server backend2:8080;
    server backend3:8080;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend_servers;
    }
}
```

Architecture:

```text
                    NGINX
                      |
                backend_servers
                      |
        +-------------+-------------+
        |             |             |
        v             v             v
   Backend-1      Backend-2      Backend-3
    :8080          :8080          :8080
```

---

# Basic NGINX Installation on Ubuntu

## 1. Update Package Repository

```bash
sudo apt update
```

## 2. Install NGINX

```bash
sudo apt install nginx -y
```

## 3. Check NGINX Status

```bash
sudo systemctl status nginx
```

Expected status:

```text
Active: active (running)
```

---

# Start and Stop NGINX

### Start NGINX

```bash
sudo systemctl start nginx
```

### Stop NGINX

```bash
sudo systemctl stop nginx
```

### Restart NGINX

```bash
sudo systemctl restart nginx
```

### Reload Configuration

```bash
sudo systemctl reload nginx
```

### Enable NGINX at Boot

```bash
sudo systemctl enable nginx
```

---

# Check NGINX Version

```bash
nginx -v
```

For detailed build information:

```bash
nginx -V
```

---

# Test NGINX Configuration

Before reloading NGINX, validate the configuration:

```bash
sudo nginx -t
```

Expected output:

```text
syntax is ok
test is successful
```

This is an important command to run before applying configuration changes.

---

# Firewall Configuration

If UFW is enabled, allow HTTP and HTTPS traffic:

```bash
sudo ufw enable
```

Allow HTTP and HTTPS:

```bash
sudo ufw allow 'Nginx Full'
```

Check firewall rules:

```bash
sudo ufw status
```

---

# Access NGINX

After installation, open:

```text
http://localhost
```

On a remote server, use:

```text
http://<server-ip>
```

If NGINX is running correctly, the default NGINX welcome page should appear.

---

# NGINX Logs

NGINX commonly stores logs under:

```text
/var/log/nginx/
```

Important files:

```text
access.log
error.log
```

View access logs:

```bash
sudo tail -f /var/log/nginx/access.log
```

View error logs:

```bash
sudo tail -f /var/log/nginx/error.log
```

---

# NGINX Directory Structure

On Ubuntu/Debian systems, a typical structure is:

```text
/etc/nginx/
├── nginx.conf
├── conf.d/
├── sites-available/
└── sites-enabled/

/var/log/nginx/
├── access.log
└── error.log
```

---

# NGINX in Kubernetes

NGINX is commonly deployed in Kubernetes as a container.

Example:

```text
                 Kubernetes Cluster
                        |
                     Service
                        |
                        v
                 +-------------+
                 | NGINX Pods  |
                 +-------------+
                  |     |     |
                  v     v     v
                Pod-1 Pod-2 Pod-3
```

Example Deployment:

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

Apply:

```bash
kubectl apply -f deployment.yaml
```

Check Pods:

```bash
kubectl get pods
```

---

# NGINX with Kubernetes Service

Example NodePort Service:

```yaml
apiVersion: v1
kind: Service

metadata:
  name: nginx-service

spec:
  type: NodePort

  selector:
    app: nginx

  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

Apply:

```bash
kubectl apply -f service.yaml
```

Check:

```bash
kubectl get svc
```

Architecture:

```text
                Client
                   |
                   v
             NodePort :30080
                   |
                   v
             NGINX Service
                   |
        +----------+----------+
        |          |          |
        v          v          v
      NGINX      NGINX      NGINX
      Pod-1      Pod-2      Pod-3
```

---

# NGINX vs Apache

| Feature | NGINX | Apache |
|---|---|---|
| Architecture | Event-driven | Process/Thread-based |
| Static content | Excellent | Excellent |
| Reverse Proxy | Yes | Yes |
| Load Balancing | Yes | Yes |
| HTTP Cache | Yes | Yes |
| High concurrency | Excellent | Good |
| Configuration | Declarative | Directive-based |
| Kubernetes usage | Very common | Common |
| Resource efficiency | High | Depends on MPM/configuration |

---

# NGINX in DevOps

NGINX is useful in DevOps environments for:

- Reverse proxy
- Load balancing
- SSL/TLS termination
- Application routing
- Static content serving
- Caching
- Kubernetes ingress architecture
- Microservices
- High-availability applications

A typical architecture:

```text
                 Internet
                    |
                    v
                  NGINX
             Reverse Proxy
                    |
        +-----------+-----------+
        |           |           |
        v           v           v
     Service-A   Service-B   Service-C
        |           |           |
        v           v           v
     Backend     Backend     Backend
```

---

# NGINX Troubleshooting Commands

### Check service status

```bash
sudo systemctl status nginx
```

### Check configuration

```bash
sudo nginx -t
```

### Check listening ports

```bash
sudo ss -lntp | grep nginx
```

### Check processes

```bash
ps -ef | grep nginx
```

### Check error logs

```bash
sudo tail -f /var/log/nginx/error.log
```

### Check access logs

```bash
sudo tail -f /var/log/nginx/access.log
```

### Test HTTP response

```bash
curl -I http://localhost
```

---

# Common NGINX Issues

## 1. NGINX is not running

Check:

```bash
sudo systemctl status nginx
```

Start:

```bash
sudo systemctl start nginx
```

---

## 2. Configuration Syntax Error

Run:

```bash
sudo nginx -t
```

Fix the configuration and test again.

---

## 3. Port 80 Already in Use

Check:

```bash
sudo ss -lntp | grep :80
```

Identify the process using port 80 and resolve the conflict.

---

## 4. 502 Bad Gateway

A `502 Bad Gateway` commonly indicates that NGINX cannot successfully communicate with the upstream backend.

Check:

```bash
sudo tail -f /var/log/nginx/error.log
```

Then verify the backend:

```bash
curl http://backend:8080
```

---

## 5. 403 Forbidden

Check:

- File permissions
- Directory permissions
- NGINX configuration
- `root` path
- SELinux/AppArmor where applicable

---

# Interview Questions

### What is NGINX?

**Answer:**

> NGINX is a high-performance, event-driven web server that can also work as a reverse proxy, load balancer, HTTP cache, and TCP/UDP proxy.

### What is the difference between a forward proxy and reverse proxy?

**Forward Proxy:**

```text
Client → Proxy → Internet
```

The proxy acts on behalf of the client.

**Reverse Proxy:**

```text
Client → NGINX → Backend Servers
```

The proxy acts on behalf of the backend servers.

### Why is NGINX highly performant?

NGINX uses an **event-driven, asynchronous, and non-blocking architecture**, allowing it to efficiently handle many concurrent connections with relatively low resource usage.

### What is the difference between reload and restart?

**Reload:**

```bash
sudo systemctl reload nginx
```

Reloads the configuration while keeping the existing service running and is generally preferred for configuration changes.

**Restart:**

```bash
sudo systemctl restart nginx
```

Stops and starts the service again.

### How do you check whether NGINX configuration is valid?

```bash
sudo nginx -t
```

### Where are NGINX logs stored?

Commonly:

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
```

---

# Summary

NGINX is a powerful web server and reverse proxy widely used in modern DevOps environments.

Its major capabilities include:

- Web serving
- Reverse proxy
- Load balancing
- HTTP caching
- SSL/TLS termination
- TCP/UDP proxying
- High-concurrency request handling
- Kubernetes integration
- Microservices routing

NGINX's event-driven architecture makes it well suited for high-traffic applications and modern cloud-native environments.



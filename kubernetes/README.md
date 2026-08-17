# Kubernetes Deployment

This directory contains Kubernetes deployment and service manifests.

## Files

- `deployment.yaml` - Creates an NGINX Deployment with 2 replicas.
- `service.yaml` - Exposes the NGINX application using a NodePort Service.

## Deploy

Apply the Deployment:

```bash
kubectl apply -f deployment.yaml

# GitLab Kubernetes Deployment

This project sets up a GitLab instance on Kubernetes using a `Makefile` to automate the deployment process. The setup includes Redis, PostgreSQL, and GitLab, configured to run within a Kubernetes cluster.

## Prerequisites

- Kubernetes cluster (Minikube, GKE, EKS, etc.)
- `kubectl` installed and configured
- `make` installed

## Files

- `pv-pvc.yaml`: Persistent Volumes and Persistent Volume Claims definitions.
- `configmap.yaml`: ConfigMap and Secrets for environment variables and sensitive data.
- `redis.yaml`: Deployment and Service definition for Redis.
- `postgresql.yaml`: Deployment and Service definition for PostgreSQL.
- `gitlab.yaml`: Deployment and Service definition for GitLab.
- `Makefile`: Automation script to manage the Kubernetes resources.

## Deploy the Application

Run the following command to set up all components:

```sh

make

```

And stop with:

```sh

make down

```

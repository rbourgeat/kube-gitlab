# GitLab Kubernetes Deployment

This project sets up a GitLab instance on Kubernetes using a `Makefile` to automate the deployment process. The setup includes Redis, PostgreSQL, and GitLab, configured to run within a Kubernetes cluster. Additionally, the deployment utilizes a LoadBalancer for **traffic distribution** and implements GitLab autoscaling for efficient resource utilization.

## Prerequisites

- Kubernetes cluster (Minikube, GKE, EKS, etc.)
- `kubectl` installed and configured
- `make` installed

## Commands

- Run the following command to set up all components:

```sh

make

```

Now open http://localhost:30080

- Stop with:

```sh

make down

```

- Log with:

```sh

make logs

```

- Check Persistent Volumes with:

```sh

make pvs

```

- Delete pvcs with:

```sh

make clean

```

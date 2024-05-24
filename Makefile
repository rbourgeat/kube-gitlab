.PHONY: all up down list logs

# File paths
PV_PVC_FILE := pv-pvc.yaml
CONFIGMAP_FILE := configmap.yaml
REDIS_FILE := redis.yaml
POSTGRESQL_FILE := postgresql.yaml
GITLAB_FILE := gitlab.yaml

# Kubernetes namespace
NAMESPACE := default

all: up

up:
	@echo "Applying Persistent Volumes and Persistent Volume Claims..."
	kubectl apply -f $(PV_PVC_FILE)
	@echo "Applying ConfigMap and Secrets..."
	kubectl apply -f $(CONFIGMAP_FILE)
	@echo "Deploying Redis..."
	kubectl apply -f $(REDIS_FILE)
	@echo "Deploying PostgreSQL..."
	kubectl apply -f $(POSTGRESQL_FILE)
	@echo "Deploying GitLab..."
	kubectl apply -f $(GITLAB_FILE)
	@echo "All components are up and running."

down:
	@echo "Deleting GitLab..."
	kubectl delete -f $(GITLAB_FILE)
	@echo "Deleting PostgreSQL..."
	kubectl delete -f $(POSTGRESQL_FILE)
	@echo "Deleting Redis..."
	kubectl delete -f $(REDIS_FILE)
	@echo "Deleting ConfigMap and Secrets..."
	kubectl delete -f $(CONFIGMAP_FILE)
	@echo "Deleting Persistent Volumes and Persistent Volume Claims..."
	kubectl delete -f $(PV_PVC_FILE)
	@echo "All components have been taken down."

list:
	@echo "Checking GitLab status..."
	@if kubectl get pods -l app=gitlab | grep -q "Running"; then \
	  NODE_IP=$$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}'); \
	  echo "GitLab is running. Access it at http://$$NODE_IP:30080"; \
	else \
	  echo "GitLab is not running."; \
	fi

logs:
	@echo "Fetching logs for GitLab..."
	POD_NAME=$$(kubectl get pods -l app=gitlab -o jsonpath='{.items[0].metadata.name}'); \
	kubectl logs $$POD_NAME -f

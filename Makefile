NAMESPACE       = default

PV_PVC_FILE     = pv-pvc.yaml
CONFIGMAP_FILE  = configmap.yaml
REDIS_FILE      = redis.yaml
POSTGRESQL_FILE = postgresql.yaml
GITLAB_FILE     = gitlab.yaml

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
	@echo "All components have been taken down."

clean:
    @read -p "Are you sure you want to delete all persistent volume claims? [Y/N] " confirm; \
    if [ "$$confirm" == "y" ] || [ "$$confirm" == "Y" ]; then \
        echo "Deleting Persistent Volume Claims..."; \
        kubectl delete -f $(PV_PVC_FILE); \
        echo "All persistent volume claims have been deleted."; \
    else \
        echo "Aborted."; \
    fi

logs:
	@echo "Fetching logs for GitLab..."
	POD_NAME=$$(kubectl get pods -l app=gitlab -o jsonpath='{.items[0].metadata.name}'); \
	kubectl logs $$POD_NAME -f

.PHONY: all up down delete-pvcs logs

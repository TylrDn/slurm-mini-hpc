COMPOSE ?= docker compose

.PHONY: up down logs submit-hello submit-gpu submit-nccl lint help

up: ## Start Slurm cluster
$(COMPOSE) up -d

down: ## Stop cluster and remove volumes
$(COMPOSE) down -v

logs: ## Tail controller logs
$(COMPOSE) logs -f slurmctld

submit-hello: ## Submit hello job
sbatch jobs/hello.sbatch

submit-gpu: ## Submit GPU job
sbatch jobs/gpu_train.sbatch

submit-nccl: ## Submit NCCL all-reduce job
sbatch jobs/nccl_allreduce.sbatch

lint: ## Run pre-commit hooks
pre-commit run --all-files

help: ## Show this help
@grep -E '^[a-zA-Z_-]+:.*?## .*' \$(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-20s %s\n", $$1, $$2}'

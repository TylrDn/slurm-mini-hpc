# slurm-mini-hpc

Minimal Slurm demo cluster powered by Docker Compose. Includes sample jobs, optional Ansible roles for VMs, and monitoring hints.

## Quickstart

```bash
make up
```

Check cluster state:

```bash
docker compose exec slurmctld sinfo
docker compose exec slurmctld squeue -a
docker compose exec slurmctld sacct
```

## Example jobs

Submit bundled examples:

```bash
make submit-hello
make submit-gpu
make submit-nccl
```

`gpu_train.sbatch` prints an informative message if no GPU is present. `nccl_allreduce.sbatch` downloads and builds `nccl-tests` via `scripts/fetch_nccl_tests.sh` and runs `all_reduce_perf`.

## Ansible deployment

The `ansible/` directory contains sample roles for installing NVIDIA drivers, container runtime, and Slurm/munge on VMs. Copy `inventory.example` and adjust hostnames.

## Monitoring

`monitoring/` includes a Prometheus scrape configuration and notes on using node-exporter and a Slurm exporter.

## Troubleshooting

Use `make logs` to tail controller logs. Inspect services with `docker compose ps`.

## Cleanup

```bash
make down
```

This stops the cluster and removes volumes.

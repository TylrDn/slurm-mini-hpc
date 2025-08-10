# Acceptance Checks

- `make up` brings cluster healthy (all services healthy).
- `make submit-hello` finishes `COMPLETED`.
- `make submit-nccl` runs `all_reduce_perf` on 2 tasks (CPU-only prints informative message).
- `pre-commit run --all-files` clean; CI passes.
- `docker compose down` cleans volumes with `make down`.

#!/bin/bash
#SBATCH -J nccl
#SBATCH -N 2
#SBATCH -o %x.%j.out
set -euo pipefail

srun bash scripts/fetch_nccl_tests.sh
srun ./nccl-tests/build/all_reduce_perf -b 8 -e 512M -f 2 || echo "NCCL test failed or GPUs unavailable."

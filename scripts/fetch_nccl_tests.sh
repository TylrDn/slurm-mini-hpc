#!/bin/bash
set -euo pipefail

if [ ! -d nccl-tests ]; then
  git clone https://github.com/NVIDIA/nccl-tests.git
fi
cd nccl-tests
make MPI=1

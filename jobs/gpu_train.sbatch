#!/bin/bash
#SBATCH -J gpu-train
#SBATCH -o %x.%j.out

if command -v nvidia-smi &>/dev/null; then
  echo "GPUs detected:"
  nvidia-smi
  echo "Running fake training..."
  sleep 5
else
  echo "No GPU available, skipping training."
fi

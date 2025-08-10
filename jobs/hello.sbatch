#!/bin/bash
#SBATCH -J hello
#SBATCH -o %x.%j.out

echo "Running on $(hostname)"
env | sort

#!/bin/bash
#SBATCH --job-name=modded-nanoGPT-predata
#SBATCH --partition=dev
#SBATCH --account=ACD115198
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=01:00:00
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail
cd "$SLURM_SUBMIT_DIR"
mkdir -p logs

source .venv/bin/activate

export NUM_PROC=$SLURM_CPUS_PER_TASK

echo "host: $(hostname) | cpus: $NUM_PROC | start: $(date)"

python ./src/nanogpt_speedrun/predata.py 20

echo "done: $(date)"
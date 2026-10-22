#!/bin/bash
#SBATCH --job-name=modded-nanoGPT-predata
#SBATCH --partition=8gpus
#SBATCH --account=ACD115198
#SBATCH --exclude=25a-hgpn001,25a-hgpn003,25a-hgpn004,25a-hgpn007,25a-hgpn071
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus-per-node=8
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

torchrun --standalone --nproc_per_node=$NUM_PROC records/track_3_optimization/train_gpt_simple.py

echo "done: $(date)"
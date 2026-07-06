#!/bin/bash
#SBATCH --job-name=Hidrogen_HF_2
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --error=error_hf_2.txt
#SBATCH --mem=8GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

echo start=$(date)
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca Hidrogen_HF_2.inp > Hidrogen_HF_2.out --oversubscribe
echo end=$(date)
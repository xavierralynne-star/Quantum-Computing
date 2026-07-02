#!/bin/bash
#SBATCH --job-name=Hidrogen_CASCI
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casci.txt
#SBATCH --mem=8GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

echo start=$(date)
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca Hidrogen_CASCI.inp > Hidrogen_CASCI.out --oversubscribe
echo end=$(date)
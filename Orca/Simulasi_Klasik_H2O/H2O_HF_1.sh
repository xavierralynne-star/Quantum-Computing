#!/bin/bash
#SBATCH --job-name=H2O_HF_1
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_hf_1.txt
#SBATCH --mem=8GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_H2O"

echo start=$(date)
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca H2O_HF_1.inp > H2O_HF_1.out --oversubscribe
echo end=$(date)
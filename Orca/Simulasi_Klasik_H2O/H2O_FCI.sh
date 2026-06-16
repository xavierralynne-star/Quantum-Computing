#!/bin/bash
#SBATCH --job-name=H2O_FCI
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_fci.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_H2O"

echo start=$(date)
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca H2O_FCI.inp > H2O_FCI.out --oversubscribe
echo end=$(date)
#!/bin/bash
#SBATCH --job-name=H2O_FCI_SP
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_fci_sp.txt
#SBATCH --mem=32GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_H2O"

echo start=$(date)

for i in $(seq -w 1 22); do
    /mgpfs/apps/nuclear/apps/orca/6.0.1/orca H2O_FCI_SP_${i}.inp > H2O_FCI_SP_${i}.out --oversubscribe
    echo "Selesai titik ke-${i}"
done

echo end=$(date)
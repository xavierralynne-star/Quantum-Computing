#!/bin/bash
#SBATCH --job-name=CH4_FCI_88_SP
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_fci_88_sp.txt
#SBATCH --mem=32GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_CH4"

echo start=$(date)

for i in $(seq -w 1 21); do
    /mgpfs/apps/nuclear/apps/orca/6.0.1/orca CH4_FCI_88_SP_${i}.inp > CH4_FCI_88_SP_${i}.out --oversubscribe
    echo "Selesai titik ke-${i}"
done

echo end=$(date)
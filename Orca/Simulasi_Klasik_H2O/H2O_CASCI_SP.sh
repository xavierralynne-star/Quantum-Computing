#!/bin/bash
#SBATCH --job-name=H2O_CASCI_SP
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casci_sp.txt
#SBATCH --output=output_casci_sp.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_H2O"

echo "=== MULAI SEMUA JOB CASCI SP ==="
echo start_total=$(date)

for i in $(seq -f "%03g" 1 22); do
    echo "--- Menjalankan titik $i ---"
    echo start=$(date)
    /mgpfs/apps/nuclear/apps/orca/6.0.1/orca H2O_CASCI_SP.${i}.inp > H2O_CASCI_SP.${i}.out --oversubscribe
    echo end=$(date)
done

echo end_total=$(date)
echo "=== SEMUA 16 TITIK SELESAI ==="
#!/bin/bash
#SBATCH --job-name=H2O_CASCI_fixR2
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casci_h2o_fixed_R2.txt
#SBATCH --output=output_casci_h2o_fixed_R2.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_H2O"

echo "=== MULAI CASCI FIXED H2O RANGE 2 (R=3.00-5.80 A) ==="
echo start_total=$(date)

for i in $(seq -f "%03g" 1 16); do
    INPFILE="H2O_CASCI_fixed_R2.${i}.inp"
    if [ ! -f "$INPFILE" ]; then
        echo "$INPFILE tidak ada, skip titik $i."
        continue
    fi
    echo "--- Menjalankan titik $i ---"
    echo start=$(date)
    /mgpfs/apps/nuclear/apps/orca/6.0.1/orca ${INPFILE} > H2O_CASCI_fixed_R2.${i}.out --oversubscribe
    echo end=$(date)
done

echo end_total=$(date)
echo "=== SEMUA TITIK CASCI FIXED H2O RANGE 2 SELESAI ==="
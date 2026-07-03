#!/bin/bash
#SBATCH --job-name=CH4_CASCI_fixed
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casci_ch4_fixed.txt
#SBATCH --output=output_casci_ch4_fixed.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_CH4"

echo "=== MULAI SEMUA JOB CASCI FIXED CH4 ==="
echo start_total=$(date)

for i in $(seq -f "%03g" 1 16); do
    INPFILE="CH4_CASCI_fixed.${i}.inp"
    if [ ! -f "$INPFILE" ]; then
        echo "$INPFILE tidak ada, skip titik $i."
        continue
    fi
    echo "--- Menjalankan titik $i ---"
    echo start=$(date)
    /mgpfs/apps/nuclear/apps/orca/6.0.1/orca ${INPFILE} > CH4_CASCI_fixed.${i}.out --oversubscribe
    echo end=$(date)
done

echo end_total=$(date)
echo "=== SEMUA TITIK CASCI FIXED CH4 SELESAI ==="
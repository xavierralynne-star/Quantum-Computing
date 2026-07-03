#!/bin/bash
#SBATCH --job-name=CH4_CASSCF_fix89
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casscf_fix89.txt
#SBATCH --output=output_casscf_fix89.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_CH4"

echo "=== RERUN CASSCF TITIK 8 DAN 9 (fix orbital switching) ==="
echo start_total=$(date)

# Titik 8 dulu -- baca orbital dari titik 7 yang sudah benar
echo "--- Titik 8 (R=1.6667 A), baca orbital dari titik 7 ---"
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca CH4_CASSCF_1_fix008.inp > CH4_CASSCF_1_fix008.out --oversubscribe

# Titik 9 -- baca orbital dari titik 8 yang sudah diperbaiki
echo "--- Titik 9 (R=1.8333 A), baca orbital dari titik 8 fix ---"
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca CH4_CASSCF_1_fix009.inp > CH4_CASSCF_1_fix009.out --oversubscribe

echo end_total=$(date)
echo "=== SELESAI ==="

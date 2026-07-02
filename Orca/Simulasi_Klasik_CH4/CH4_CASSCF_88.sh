#!/bin/bash
#SBATCH --job-name=CH4_CASSCF_88_OPT
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --error=error_casscf_88_opt.txt
#SBATCH --mem=16GB

module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

cd "/mgpfs/home/shakim/Quantum Computing/Orca/Simulasi_Klasik_CH4"

echo start=$(date)
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca CH4_CASSCF_88.inp > CH4_CASSCF_88_OPT.out --oversubscribe
echo end=$(date)
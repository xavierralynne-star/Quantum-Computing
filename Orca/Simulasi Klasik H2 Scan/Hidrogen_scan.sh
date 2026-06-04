#!/bin/bash
  
#SBATCH --job-name=H2_simulation_scan
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --error=error.txt
#SBATCH --mem=128GB

## Required Modules
module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

echo "start = $(date)"

# Put your job here
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca Hidrogen_scan.inp > hasil_scan.out --oversubscribe

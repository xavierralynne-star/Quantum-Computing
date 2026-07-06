#!/bin/bash
  
#SBATCH --job-name=H2_simulation_scan_2
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --error=error_scan_2.txt
#SBATCH --mem=8GB

## Required Modules
module load openmpi4/4.1.4
module load nuclear/orca/6.0.1

echo "start = $(date)"

# Put your job here
/mgpfs/apps/nuclear/apps/orca/6.0.1/orca Hidrogen_scan_2.inp > hasil_scan_2.out --oversubscribe

#!/bin/bash
#SBATCH --partition=broadwell
#SBATCH -N 1 
##SBATCH --reservation=variant
srun /opt/adw/bin/adw run -i qbioturin/mutect2:0.2 -c "/bin/bash -c '{{streamflow_command}}'"

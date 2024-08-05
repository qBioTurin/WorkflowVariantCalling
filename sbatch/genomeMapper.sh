#!/bin/bash
#SBATCH --partition=broadwell
#SBATCH -N 1 
##SBATCH --reservation=variant
srun /opt/adw/bin/adw run -i qbioturin/genomemapper:0.5.1 -c "/bin/bash -c '{{streamflow_command}}'"

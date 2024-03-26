#!/bin/bash

#SBATCH --job-name=GFP_min          
#SBATCH --partition=batch              
#SBATCH --nodes=1                      
#SBATCH --ntasks=10                    
#SBATCH --cpus-per-task=1               
#SBATCH --mem-per-cpu=2gb               
#SBATCH --time=24:00:00                 
#SBATCH --output=minimization.%j.out    
#SBATCH --error=minimization.%j.err     
#SBATCH --mail-user=jcu23686@uga.edu        
#SBATCH --mail-type=ALL                 

ml Amber/18-fosscuda-2018b-AmberTools-18-patchlevel-10-8
source ${AMBERHOME}/amber.sh

cd $SLURM_SUBMIT_DIR

# PMEMD: Job1: minimization, solvent
mpiexec --mca mpi_cuda_support 0 ${AMBERHOME}/bin/pmemd.MPI -O \
 -i min_solvent.in\
 -o min_solvent.out\
 -p gfp.parm7\
 -c gfp.rst7\
 -ref gfp.rst7\
 -r gfp_min_solvent.rst7

# PMEMD: Job2: minimation, whole system
mpiexec --mca mpi_cuda_support 0 ${AMBERHOME}/bin/pmemd.MPI -O\
 -i min_all.in\
 -o min_all.out\
 -p gfp.parm7\
 -c gfp_min_solvent.rst7\
 -ref gfp_min_solvent.rst7\
 -r gfp_min_all.rst7


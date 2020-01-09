#!/bin/bash
#---Number of cores
#SBATCH -c 2

#---Job's name in SLURM system
#SBATCH -J S01E02

#---Error file
#SBATCH -e eS01E02

#---Output file
#SBATCH -o oS01E02

#---Queue name
#SBATCH --account iacc_nbc

#---Partition
#SBATCH -p centos7
########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load singularity-3

singularity exec --cleanenv /scratch/tsalo006/stranger-things/ffmpeg.sif /scratch/tsalo006/stranger-things/scripts/run_S01E02.sh

#!/bin/bash
#---Number of cores
#SBATCH -c 1

#---Job's name in SLURM system
#SBATCH -J S01E06

#---Error file
#SBATCH -e eS01E06

#---Output file
#SBATCH -o oS01E06

#---Queue name
#SBATCH --account iacc_nbc

#---Partition
#SBATCH -p centos7
########################################################
export NPROCS=`echo $LSB_HOSTS | wc -w`
export OMP_NUM_THREADS=$NPROCS
. $MODULESHOME/../global/profile.modules
module load singularity-3

singularity exec /scratch/tsalo006/stranger-things/ffmpeg.sif /scratch/tsalo006/stranger-things/scripts/run_S01E06.sh

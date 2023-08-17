#!/bin/bash -l

### For MPI jobs.

### To use two nodes, with one task per node
#SBATCH -n 16

#SBATCH --nodes=1

### Which queue or partition to use

#SBATCH -p cpu

### Slurm does not support using variables in the #SBATCH section, so we need to set the job name in the submit command if we want to run loops.

### Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds"

#SBATCH --time=0:12

# Insert here your project name and uncomment

#module load xtb_kcl
module load crest_kcl


export OMP_NUM_THREADS=,1

export OMP_STACKSIZE=4G



# You should not need to modify below

###  -V -CHECK THE SECOND LINK ABOVE
#SBATCH --export=all

### This is default in Slurm
### $ -cwd                                                                                                                                              

#Put your username

#Execution Line

path_to_file=/scratch/users/k20112660/crest/param_protocol/2.generate_conformers/crest_rotamers.xyz

### use --ewin to set energy threshold (default 6 kcal/mol)


crest ../2.generate_conformers/crest_best.xyz --cregen ../2.generate_conformers/crest_conformers.xyz --esort --ewin 3 --cluster 4 --T 16 > GZW1C1.e3.n4.log


#!/bin/bash -l

### For MPI jobs.

### To use two nodes, with one task per node
#SBATCH -n 16

#SBATCH --nodes=1

### Which queue or partition to use

#SBATCH -p cpu

### Slurm does not support using variables in the #SBATCH section, so we need to set the job name in the submit command if we want to run loops.

### Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds"                      

#SBATCH --time=10                                                                                                                                                                  

# Insert here your project name and uncomment                                                                                                                                       

module load xtb_kcl
#module load crest_kcl

                                                                                                          
export OMP_NUM_THREADS=$NSLOTS,1

export OMP_STACKSIZE=4G



# You should not need to modify below                                                                                                                                               

###  -V -CHECK THE SECOND LINK ABOVE                                                                                                                                                
#SBATCH --export=all                                                                                                                                                                

### This is default in Slurm                                                                                                                                                        
### $ -cwd                                                                                                                                                                          

#Put your username                                                                                                                                                                  

#Execution Line

folder=../../0.put_original_structure_here

path_to_file=$folder/*
file=`basename $path_to_file`
structure=${file%.*}
echo $path_to_file
echo $file
echo $structure

xtb $path_to_file --opt extreme --gfn2 >$structure.xtb.log

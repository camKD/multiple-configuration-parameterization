#!/bin/bash -l

### For MPI jobs.

### To use two nodes, with one task per node
#SBATCH -n 16

#SBATCH --nodes=1

### Which queue or partition to use

#SBATCH -p cpu

### Slurm does not support using variables in the #SBATCH section, so we need to set the job name in the submit command if we want to run loops.

### Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds"                      

#SBATCH --time=30                                                                                                                                                                  

# Insert here your project name and uncomment                                                                                                                                       

#module load xtb_kcl
module load crest_kcl

                                                                                                          
export OMP_NUM_THREADS=$NSLOTS,1

export OMP_STACKSIZE=4G



# You should not need to modify below                                                                                                                                               

###  -V -CHECK THE SECOND LINK ABOVE                                                                                                                                                
#SBATCH --export=all                                                                                                                                                                

### This is default in Slurm                                                                                                                                                        
### $ -cwd                                                                                                                                                                          

#Put your username                                                                                                                                                                  

#Execution Line

### YOU MAY NEED TO CHANGE THE FOLDER VARIABLE

folder=../1.optimise_at_same_level/xtb_opt
file=xtbopt.xyz

# Change the name of the structure variable!!!
echo "Change the name of the structure variable!!!"

path_to_file=$folder/$file
structure=epctcn

### use --ewin to set energy threshold (default 6 kcal/mol)

energy=3


crest $path_to_file --gfn2 --esort --ewin $energy  --T 16 >$structure.crest.log

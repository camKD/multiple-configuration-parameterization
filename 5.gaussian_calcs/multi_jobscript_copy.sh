#!/bin/bash -l

#SBATCH -p cpu
#SBATCH --time=0-2:00

#echo "What is the general name for your input file?"
#read input
#echo "How many configurations are you running?"
#read configs

for filename in ../4.generate_gaussian_files/*hf.in
do
jobname=$filename
echo "Submitting job "$jobname
sbatch --job-name $jobname --export=jobname=$jobname jobscript.sh
echo "Try sleeping less"
sleep 10s
done

  

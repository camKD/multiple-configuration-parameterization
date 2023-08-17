#!/bin/bash


### Set up variables ###

weight_file=../7.weights/energy_weights.log # Weights file containing list of conformers, energies and relative boltzmann weights
n_config=`wc -l < $weight_file` # The total number of configurations
antechamber_method=gaff

files=$(awk '(NR<='$n_config'){print $1}' $weight_file | tr '\n' ' ')
for file in $files; do
  logs="$logs $file.hf.log"
done
min_log=$(echo "$logs" | awk '{print $1}') # The log for the minimum energy configuration
min_name=${min_log%.hf.log}
min_pdb=../8.lowest_config_to_pdb/*.pdb
log_folder=../4.generate_gaussian_files

### Error catching ###
if [ -f "$weight_file" ]; then
  echo "The weight file $weight_file exists"
else
  echo "Error: The weight file $weight_file does not exist"
  exit 1
fi

if [ -f $min_pdb ]; then
  echo "The minimum energy pdb $min_pdb exists"
else
  echo "Error: The minimum energy pdb $min_pdb does not exist"
  exit 1
fi

if [ -f "readit.f" ]; then
  echo "The file readit.f exists"
else
  echo "Error: The file readit.f does not exist"
  exit 1
fi

if [ -f "esp1.sh" ]; then
  echo "The file esp1.sh exists"
else
  echo "Error: The file esp1.sh does not exist"
  exit 1
fi


### ###

num_atoms=$(grep -c '^HETATM' $min_pdb)

### Manual RESP? Necessary? ###

rm esp1_tot.dat # Remove any previously produced data files

echo "problem 1"
for log in $logs
do
    echo $log
    grep -n "ESP Fit" $log_folder/$log > nespfile
    nespvar=$(wc -l < nespfile)
    echo $nespvar
    echo \
	"$num_atoms $nespvar
" > inputesp1
    ./esp1.sh $log_folder/$log < inputesp1
    cat esp1.dat >> esp1_tot.dat
    name="${log%.hf.log}"
    cp esp1.dat esp1_$name.dat
done

cp esp1_tot.dat esp1_tot_beginning.dat
rm inputesp1

### ###

echo "problem 2"

source ~/.bashrc
source activate AmberTools22

antechamber -fi gout -fo ac -i $log_folder/$min_log -o $min_name.ac -c resp -pf y

respgen -i $min_name.ac -o $min_name.respin1 -f resp1 -n $n_config
respgen -i $min_name.ac -o $min_name.respin2 -f resp2 -n $n_config

for j in 1 2
do
    tr '\n' 'X' < $min_name.respin$j > prov

    for log in logs
    do
	weight=$(awk '(NR=="'$i'"){print $3}' $weight_file)
	echo "Respin$j , Weights retrieving: $i $weights"
	sed -i s/'1\.0'/$weight/1 prov
    done

    tr 'X' '\n' < prov > $min_name.newrespin$j
done

resp -O -i $min_name.newrespin1 -o $min_name.respout1 -e esp1_tot.dat -t $min_name.qout1
resp -O -i $min_name.newrespin2 -o $min_name.respout2 -e esp1_tot.dat -q $min_name.qout1 -t $min_name.qout2

antechamber -i $min_name.ac -fi ac -o $min_name.resp.ac -fo ac -c rc -cf $min_name.qout2
antechamber -i $min_name.ac -fi ac -o $min_name.stage1.resp.ac -fo ac -c rc -cf $min_name.qout1

### ###

antechamber -fi ac -i $min_name.resp.ac -c wc -cf $min_name.crg
antechamber -fi pdb -fo prepi -i $min_pdb -o $min_name.prep -c rc -cf $min_name.crg -j 4 -at gaff

parmchk2 -i $min_name.prep -f prepi -o $min_name.frcmod

conda deactivate

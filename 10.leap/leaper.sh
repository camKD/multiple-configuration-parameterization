#!/bin/bash

pdb=$(echo ../9.amber/*PDB)
prep=$(echo ../9.amber/*prep)
frcmod=$(echo ../9.amber/*frcmod)

mol=GZW1C1

rm leap.in

echo "source leaprc.gaff

loadAmberPrep $prep
loadAmberParams $frcmod
UN = loadpdb $pdb

check UN

saveAmberParm UN $mol.prmtop $mol.inpcrd
savepdb UN $mol.pdb
quit
" > leap.in

source ~/.bashrc
source activate AmberTools22

rm leap.log
tleap -s -f leap.in > leap.log

conda deactivate

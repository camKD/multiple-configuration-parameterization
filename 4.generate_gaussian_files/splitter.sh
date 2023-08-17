#!/bin/bash

# Number of conformers
n=4
file=../3.clustering/*clustered.xyz
file_length=$(wc -l < "$file")
split=$((file_length / n))
atoms=$((split-2))

split -l $split $file $prefix -d

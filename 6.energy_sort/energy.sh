#!/bin/bash

rm energy.log

for file in ../4.generate_gaussian_files/*hf.log
do
    jf=$(basename "$file")
    prefix=${jf/.hf.log}
    energy=`grep 'E(R' $file`
    #echo $energy
    arr=($energy)
    #echo ${arr[4]}
    echo $prefix ${arr[4]} >> energy.log
done

#lowest_en=`cat lowest_en.dat`
#echo gopt $lowest_en >> energy.log

sort -k2 -n energy.log > temp.log
mv temp.log energy.log
le=`head -1 energy.log`

echo "The lowest energy config is $le"
echo "Take the xyz for this config and use it in the next step"

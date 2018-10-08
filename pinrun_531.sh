#! /bin/bash -l

#SBATCH -A snic2018-8-228
#SBATCH -p core -n 1
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ZaferIbrahim.Esen.7260@student.uu.se
#SBATCH -o run_outputs/531-deepsjeng-r-%j.out

runfolder="/proj/snic2018-8-228/spec17_master/benchspec/CPU/531.deepsjeng_r/run/run_base_refrate_myfirsttest-m64.0000"
outfolder="$(pwd)/run_outputs"

outputfile=$1
cachesize=$2
assoc=$3
linesize=$4
instcache=$5

cd $runfolder

/proj/snic2018-8-228/pin_tutorial/pin/pin -t \
/proj/snic2018-8-228/pin_tutorial/pin/source/tools/MemoryTrans/obj-intel64/memtrans_multi.so \
-o $outputfile -s $cachesize -a $assoc -l $linesize -ic $instcache -- \
../run_base_refrate_myfirsttest-m64.0000/deepsjeng_r_base.myfirsttest-m64 ref.txt 

mv ./$outputfile $outfolder/$outputfile

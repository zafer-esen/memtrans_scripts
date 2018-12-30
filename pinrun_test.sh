#! /bin/bash -l

#SBATCH -A snic2018-8-228
#SBATCH -t 0-00:15:00
#SBATCH -p devel
#SBATCH -N 1 -n 1
#SBATCH --mail-type=END
#SBATCH --mail-user=ZaferIbrahim.Esen.7260@student.uu.se
#SBATCH -o run_outputs/test-%j.out

runfolder="."
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
ls

mv ./$outputfile $outfolder/$outputfile

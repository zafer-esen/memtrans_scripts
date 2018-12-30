#! /bin/bash -l

bmsname="pinrun_test.sh"
timestamp=$(date +%y%m%d-%H%M%S)
outname="test" #output name excluding -jobid.out at the end
outfolder="$(pwd)/run_ouputs"

outputfile="$outname-$timestamp.out"
cachesize="65536"
assoc="8"
linesize="64"
instcache="1"

outtext=$(sbatch $bmsname $outputfile $cachesize $assoc $linesize $instcache) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-$timestamp $outname-$timestamp-${outtext##* }

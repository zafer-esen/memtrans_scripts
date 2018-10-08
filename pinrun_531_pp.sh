#! /bin/bash -l

bmsname="pinrun_531.sh"
outname="531-deepsjeng-r" #output name excluding -jobid.out at the end
outfolder="$(pwd)/run_ouputs"

outputfile="$outname-$timestamp.out"
cachesize="16777216"
assoc="8"
linesize="64"
instcache="1"

outtext=$(sbatch $bmsname $outputfile $cachesize $assoc $linesize $instcache) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-$timestamp $outname-$timestamp-${outtext##* }


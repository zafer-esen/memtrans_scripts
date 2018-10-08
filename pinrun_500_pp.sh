#! /bin/bash -l

bmsname="pinrun_500_1.sh"
outname="500-perlbench-r-1" #output name excluding -jobid.out at the end

outputfile="$outname-$timestamp.out"
cachesize="16777216"
assoc="8"
linesize="64"
instcache="1"

outtext=$(sbatch $bmsname $outputfile $cachesize $assoc $linesize $instcache) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-$timestamp $outname-$timestamp-${outtext##* }

bmsname="pinrun_500_2.sh"
outname="500-perlbench-r-2" #output name excluding -jobid.out at the end
outputfile="$outname-$timestamp.out"

outtext=$(sbatch $bmsname $outputfile $cachesize $assoc $linesize $instcache) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-$timestamp $outname-$timestamp-${outtext##* }

bmsname="pinrun_500_3.sh"
outname="500-perlbench-r-3" #output name excluding -jobid.out at the end
outputfile="$outname-$timestamp.out"

outtext=$(sbatch $bmsname $outputfile $cachesize $assoc $linesize $instcache) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-$timestamp $outname-$timestamp-${outtext##* }


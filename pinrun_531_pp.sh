#! /bin/bash -l

bmsname="pinrun_531.sh"
outname="531-deepsjeng-r" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

#! /bin/bash -l

bmsname="pinrun_523.sh"
outname="523-xalancbmk-r" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

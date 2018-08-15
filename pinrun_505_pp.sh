#! /bin/bash -l

bmsname="pinrun_505.sh"
outname="505-mcf-r" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

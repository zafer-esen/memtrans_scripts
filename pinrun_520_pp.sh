#! /bin/bash -l

bmsname="pinrun_520.sh"
outname="520-omnetpp-r" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

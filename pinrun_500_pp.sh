#! /bin/bash -l

bmsname="pinrun_500_1.sh"
outname="500-perlbench-r-1" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

bmsname="pinrun_500_2.sh"
outname="500-perlbench-r-2" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }

bmsname="pinrun_500_3.sh"
outname="500-perlbench-r-3" #output name excluding -jobid.out at the end

outtext=$(sbatch $bmsname) \
&& sbatch --dependency=afterok:${outtext##* } \
create_report.sh $outname-${outtext##* }
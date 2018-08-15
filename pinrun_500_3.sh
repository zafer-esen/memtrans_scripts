#! /bin/bash -l

#SBATCH -A snic2018-8-228
#SBATCH -p core -n 1
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ZaferIbrahim.Esen.7260@student.uu.se
#SBATCH -o run_outputs/500-perlbench-r-3-%j.out

runfolder="/proj/snic2018-8-228/bms_normalsize/500.perlbench_r/run/run_base_refrate_myfirsttest-m64.0000"

cd $runfolder

/proj/snic2018-8-228/pin_tutorial/pin/pin -t \
/proj/snic2018-8-228/pin_tutorial/pin/source/tools/MemoryTrans/obj-intel64/memtrans2.so -- \
$runfolder/perlbench_r_base.myfirsttest-m64 -I./lib splitmail.pl 6400 12 26 16 100 0
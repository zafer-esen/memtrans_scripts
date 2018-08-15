#! /bin/bash -l

#SBATCH -A snic2018-8-228
#SBATCH -p core -n 1
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ZaferIbrahim.Esen.7260@student.uu.se
#SBATCH -o run_outputs/505-mcf-r-%j.out

runfolder="/proj/snic2018-8-228/bms_normalsize/505.mcf_r/run/run_base_refrate_myfirsttest-m64.0000"

cd $runfolder

/proj/snic2018-8-228/pin_tutorial/pin/pin -t \
/proj/snic2018-8-228/pin_tutorial/pin/source/tools/MemoryTrans/obj-intel64/memtrans2.so -- \
../run_base_refrate_myfirsttest-m64.0000/mcf_r_base.myfirsttest-m64 inp.in
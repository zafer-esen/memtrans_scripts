#! /bin/bash -l

#SBATCH -A snic2018-8-228
#SBATCH -p core -n 1
#SBATCH -t 0-00:30:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ZaferIbrahim.Esen.7260@student.uu.se
#SBATCH -o run_outputs/531-deepsjeng-r-%j-repgen.log

fileaddr="../run_outputs/$1.out"
figfolder="../matlab_figures/$2"
figname="$2"

echo Starting to create the figures and latex report for file: "$2.out"...

#create the folder for the figure and report to be placed in
mkdir matlab_figures/$2
echo Folder created: matlab_figures/$2...

#matlab folder must be located inside the folder where the script is run
cd matlab
module load matlab/R2018a
echo MATLAB module loaded, running MATLAB executable...

#run the script which will generate the figures and the latex report (uncompiled)
memtrans_plotter/for_testing/run_memtrans_plotter.sh \
/sw/apps/matlab/x86_64/R2018a \
$figname $fileaddr $figfolder

module unload matlab/R2018a

echo Compiling latex report...

cd $figfolder
#compile the latex report (double compile to get the refs correct)
pdflatex $2_report.tex
pdflatex $2_report.tex


cd ..
echo Report creation complete!

#!/bin/bash

#PBS -N blastp_blast_to_python
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=1:00:00
#PBS -q debug

blastRaw=D_pul_vs_D_obt_blastout_mcl.txt
outputName=D_pul_vs_D_obt_blastout_mcl.txt.hit-frac0.5.minusLogEvalue

ScriptDir=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/DaphniaOrthologs/scripts

orthoWD=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/obtusa_blast/

cd $orthoWD

echo "Processing blast output for analysis by mcl."

#$ScriptDir/blast_to_mcl.py $blastRaw 0.5

mcl $outputName --abc -te 5 -tf 'gq(5)' -I 1.4 -o hit-frac0.5_I1.4_e5
mcl $outputName --abc -te 5 -tf 'gq(5)' -I 2 -o hit-frac0.5_I2_e5

echo "Job Complete!"

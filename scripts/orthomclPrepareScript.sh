#!/usr/bin/bash

baseDir=/N/dc2/scratch/rtraborn/Obtusa_orthologs/obtusa_blast/
inputDir=fastaDir

Dp_fasta=/N/dc2/scratch/rtraborn/Obtusa_orthologs/obtusa_blast/PA42.4.1.cds_longest.aa.fasta
Do_fasta=/N/dc2/scratch/rtraborn/Obtusa_orthologs/obtusa_blast/D_obtusa_aa.fasta

cd $baseDir
mkdir $inputDir
cd $inputDir

orthomclAdjustFasta Dpl $Dp_fasta 1
orthomclAdjustFasta Dob $Do_fasta 1

cd ..

orthomclFilterFasta $inputDir 20 20

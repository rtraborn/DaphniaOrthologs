#!/bin/bash

#PBS -N blastp_orthomcl
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=16:00:00

proteins=goodProteins.fasta

module load blast

orthoWD=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/obtusa_blast 

cd $orthoWD

echo "Creating a blast database for the orthomcl filtered protein."

makeblastdb -in $proteins -title Daphnia_species_orthomcl -dbtype prot -parse_seqids

echo "Doing a blastp all-v-all for Daphnia pulex and Daphnia obtusa"

blastp -query $proteins -db $proteins -outfmt 6 > D_pul_vs_D_obt_blastout.txt

echo "Job Complete!"

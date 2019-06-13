#!/bin/bash

#PBS -N blastp_mcl
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=12:00:00

proteins=goodProteins.fasta

module load blast

orthoWD=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/obtusa_blast 

cd $orthoWD

echo "Creating a blast database for the orthomcl filtered protein."

#makeblastdb -in $proteins -title Daphnia_species_orthomcl -dbtype prot -parse_seqids

echo "Doing a blastp all-v-all for Daphnia pulex and Daphnia obtusa"

blastp -query $proteins -db $proteins -num_threads 16 -evalue 1e-5 -max_target_seqs 1000 -outfmt '6 qseqid qlen sseqid slen frames pident nident length mismatch gapopen qstart qend sstart send evalue bitscore' > D_pul_vs_D_obt_blastout_mcl.txt

echo "Job Complete!"

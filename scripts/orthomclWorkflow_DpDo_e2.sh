#!/bin/bash

#PBS -N orthomcl_analysis
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=1:00:00
#PBS -q debug

mcl=/N/u/rtraborn/Carbonate/genome_analysis/mcl/bin/mcl
orthoWD=/N/dc2/scratch/rtraborn/Obtusa_orthologs/obtusa_blast
blastOut=D_pul_vs_D_obt_blastout.txt
similarSeq=DpDo_e2_out.bpo
fastaDir=blastp_e2
configFile=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/DaphniaOrthologs/config/orthomcl.config
scriptsDir=/N/u/rtraborn/Carbonate/scratch/Obtusa_orthologs/DaphniaOrthologs/scripts

cd $orthoWD

echo "Starting the workflow"

orthomclInstallSchema $configFile

echo "Parsing the BLAST output with orthocmcl"

orthomclBlastParser $blastOut $fastaDir > $similarSeq

echo "Loading the BLAST data into the orthmcl database on RDC"

orthomclLoadBlast $configFile $similarSeq

echo "Computing the pairs on the orthmcl database on RDC"

orthomclPairs $configFile DpDo_orthomclPairs_e2.log cleanup=no

echo "Running orthomclDumpPairsFiles on orthmcl database on RDC"

orthomclDumpPairsFiles $configFile

echo "Running mcl for clustering"

$mcl mclInput --abc -I 2.0 -analyze y -o mclOutput_e2.out

echo "Converting the MCL clusters into OrthoMCL groups"

$scriptsDir/orthomclMclToGroups OG 1 < mclOutput_e2.out > mclOutput_e2.table

echo "Converting the orthologous groups into a table of counts per species"

$scriptsDir/CopyNumberGen.sh mclOutput_e2.table > DpDo_e2_CopyNum.txt

echo "Identifying single-copy orthologs (SCOs)"

$scriptsDir/ExtractSCOs.sh DpDo_e2_CopyNum.txt > DpDo_e2_SCOs.txt

echo "Job Complete!"

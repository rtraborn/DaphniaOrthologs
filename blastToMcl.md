### How to run the blastp -> mcl clustering pipeline

1. Start with the protein fasta files provided via the cloud link. We're going to use the last one, `goodProteins.fasta`, which is a combination of filtered proteins from both D. obtusa and D. pulex:
- Dpl.fasta
- Dob.fasta
- goodProteins.fasta

2. After making the necessary adjustments, perform all-vs-all blast using the following job script `blast_mcl.sh`.

`qsub blast_mcl.sh`

3. Next, inspect the output of the previous job in the output directory. Once you see a blast output file then you can run the next script `blast_to_mcl_batch.sh`, which uses a blast-parsing python script, `blast_to_mcl.py` written by Chaoxian Zhao (czhao63@asu.edu). 

`qsub blast_to_mcl_batch.sh`

4. You should now see 2 output files containing the orthologous groups estimated by this procedure. The 2 files differ only in the inflation parameter used by mcl. The job is complete!

-Taylor
#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -N 1
#SBATCH -n 68
#SBATCH -t 02:00:00
#SBATCH -p normal
#SBATCH -J bowtie2
#SBATCH --mail-type BEGIN,END,FAIL
#SBATCH --mail-user scottdaniel@email.arizona.edu

#for local testing#####
#if the singularity.conf is right, then /vagrant should be auto-shared
#export WORK="/vagrant"
#export GUEST="/work"
########################

export OUT_DIR="$WORK/bowtie_rna_test"

#export MY_PARAMRUN="$HOME/launcher/paramrun"

[[ -d "$OUT_DIR" ]] && rm -rf $OUT_DIR/*

#    -g "$WORK/genomes" \

bash run.sh \
    -g "$WORK/centrifuge_test/genomes" \
    -x "$WORK/bt2_index/genome" \
    -1 "$WORK/in/rna/RNA_2_GCCAAT_L008_R1_001.fastq $WORK/in/rna/RNA_2_GCCAAT_L008_R1_002.fastq $WORK/in/rna/RNA_2_GCCAAT_L008_R1_003.fastq" \
    -2 "$WORK/in/rna/RNA_2_GCCAAT_L008_R2_001.fastq $WORK/in/rna/RNA_2_GCCAAT_L008_R2_002.fastq $WORK/in/rna/RNA_2_GCCAAT_L008_R2_003.fastq" \
    -O $OUT_DIR \
    -f fastq -t 68 \
    -a end-to-end \
    -e sensitive

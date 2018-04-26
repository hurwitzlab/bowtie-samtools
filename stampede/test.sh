#!/bin/bash

#SBATCH -A iPlant-Collabs
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -p development
#SBATCH -J cntrfuge
#SBATCH --mail-type BEGIN,END,FAIL
#SBATCH --mail-user scottdaniel@email.arizona.edu

#for local testing#####
#if the singularity.conf is right, then /vagrant should be auto-shared
export WORK="/vagrant"
#export GUEST="/work"
########################

export OUT_DIR="$WORK/bowtie_test"

#export MY_PARAMRUN="$HOME/launcher/paramrun"

[[ -d "$OUT_DIR" ]] && rm -rf $OUT_DIR/*

#-i "$WORK/genomes"

bash run_simple.sh \
    -d "$WORK/bowtie2-db/genome.fna" \
    --dist 2 \
    -r "$WORK/rna/control" \
    -O $OUT_DIR \
    -f fastq -t 4 \
    -y paired --merge-output


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
export HOST="/vagrant"
export GUEST="/work"
########################

export OUT_DIR="$HOST/bowtie_test"

#export MY_PARAMRUN="$HOME/launcher/paramrun"

[[ -d "$OUT_DIR" ]] && rm -rf $OUT_DIR/*

bash run.sh -i "$HOST/genomes" \
    -r "$HOST/rna/control" \
    -O $OUT_DIR \
    -f fastq -t 4


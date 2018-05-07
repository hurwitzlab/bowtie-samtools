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
#export WORK="/vagrant"
#export GUEST="/work"
########################

export OUT_DIR="$WORK/control_out"

export MY_PARAMRUN="$HOME/launcher/paramrun"

[[ -d "$OUT_DIR" ]] && rm -rf $OUT_DIR/*

#    -g "$WORK/genomes" \

bash run_simple.sh \
    -x "$WORK/bt2_index/genome" \
    -1 /$WORK/rna/control/RNA_control_R1_sample_01.fastq.gz,/$WORK/rna/control/RNA_control_R1_sample_02.fastq.gz,/$WORK/rna/control/RNA_control_R1_sample_03.fastq.gz \
    -2 /$WORK/rna/control/RNA_control_R2_sample_01.fastq.gz,/$WORK/rna/control/RNA_control_R2_sample_02.fastq.gz,/$WORK/rna/control/RNA_control_R2_sample_03.fastq.gz \
    -O $OUT_DIR \
    -f fastq -t 12

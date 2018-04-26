#!/bin/bash

#SBATCH -J bowtie2
#SBATCH -A iPlant-Collabs 
#SBATCH -N 4
#SBATCH -n 1
#SBATCH -t 24:00:00
#SBATCH -p normal

# Author: Scott G. Daniel <scottdaniel@email.arizona.edu>

###Uncomment when back on tacc#
#module load tacc-singularity 
#module load launcher

#
# Set up defaults for inputs, constants
#
#INPUT_DIR="./" #-i | --input-dir
#READS_DIR="./" #-r | --reads | --reads-dir
#INPUT_DB="genome.fna" #-d | --db | --input-db
#INPUT_FMT="fastq" #-f | --fmt | --input-format
#KEEP_SAM="FALSE" #-k | --keep-sam
#MERGE_OUTPUT="FALSE" #-m | --merge-args
#MERGE_NAME="bowtie2-run.sam" #-n | --merge-name
#REMOVE_TMP="FALSE" #-z | --remove-tmp
#LOG_FN="bowtie2-read-mapping.log" #-l | --log-file
#ALIGN_TYPE="end-to-end" #-a | --alignment-type
#GLOBAL_PRESETS="sensitive" #-e | --end-to-end-presets
#LOCAL_PRESETS="sensitive-local" #-c | --local-presets
#NON_DETERMINISTIC="FALSE" #-N | --non-deterministic
#MININS="0" #-I | --minins
#MAXINS="2000" #-X | --maxins
#THREADS="1" #-t | --threads
SING_IMG="bowtie_sam.img" #-S | --sing-img
#OUT_DIR="./out_dir" #-O | --out-dir

#check for centrifuge image
if [[ ! -e "$SING_IMG" ]]; then
    echo "Missing SING_IMG \"$SING_IMG\""
    exit 1
fi

# Some needed functions
#
function lc() { 
    wc -l "$1" | cut -d ' ' -f 1 
}

function HELP() {

    singularity exec $SING_IMG bowtie_batch.py -h
    
    exit 0
}

#
# Show HELP if no arguments
#
[[ $# -eq 0 ]] && echo "Need some arguments" && HELP

set -u

#Read the arguments
# In case you wanted to check what variables were passed
echo "ARG = $*"

#
# Verify existence of various directories, files
#

#Need to concatenate all the fastas into one
#Do this in python
#if [[ ! -e "$INPUT_DB" ]]; then
#    echo "Searching $INPUT_DIR for genome fastas"
#    find $INPUT_DIR -iname "*.fna" > $GENOME_LIST
#    echo "Found $(lc $GENOME_LIST) in $INPUT_DIR"
#    if [[ $(lc $GENOME_LIST) -lt 1 ]]; then
#        echo "No genome fastas found!"
#        exit 1
#    else
#        sed 's/\n/ /' $GENOME_LIST | xargs -I file cat file > $INPUT_DB
#    fi
#fi

#Run bowtie_batch
singularity run $SING_IMG $@

echo "Done, look in OUT_DIR \"$OUT_DIR\""
echo "Comments to Scott Daniel <scottdaniel@email.arizona.edu>"


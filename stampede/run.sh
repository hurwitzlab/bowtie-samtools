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

set -u

#
# Set up defaults for inputs, constants
#
#leaving everything blank since bowtie_batch.py sets the defaults
READS_DIR=""
INPUT_DB=""
INPUT_FMT=""
SEPARATE=""
READ_TYPES=""
DISTANCE=""
FILTER=""
UNPAIR_TERM=""
PAIR_TERM=""
KEEP_SAM=""
MERGE_OUTPUT=""
MERGE_NAME=""
REMOVE_TMP=""
LOG_FN=""
ALIGN_TYPE=""
GLOBAL_PRESETS=""
LOCAL_PRESETS=""
NON_DETERMINISTIC=""
TRIM5=""
TRIM3=""
MININS=""
MAXINS=""
CENTRIFUGE_IMG="bowtie_sam.img"

#If you have your own launcher setup on stampede2 just point MY_PARAMRUN at it
#this will override the TACC_LAUNCHER...
PARAMRUN="${MY_PARAMRUN:-$TACC_LAUNCHER_DIR/paramrun}"

#
# Some needed functions
#
function lc() { 
    wc -l "$1" | cut -d ' ' -f 1 
}

function HELP() {
    echo "See bowtie_batch.py for help"
    exit 0
}

#
# Show HELP if no arguments
#
[[ $# -eq 0 ]] && HELP

#check for centrifuge image
if [[ ! -e "$CENTRIFUGE_IMG" ]]; then
    echo "Missing CENTRIFUGE_IMG \"$CENTRIFUGE_IMG\""
    exit 1
fi
#
# Verify existence of various directories, files
#
[[ ! -d "$OUT_DIR" ]] && mkdir -p "$OUT_DIR"

###Uncomment when back on TACC
#if [[ ! -d "$TACC_LAUNCHER_DIR" ]]; then
#    echo "Cannot find TACC_LAUNCHER_DIR \"$TACC_LAUNCHER_DIR\""
#    exit 1
#fi
#
#if [[ ! -f "$PARAMRUN" ]]; then
#    echo "Cannot find PARAMRUN \"$PARAM_RUN\""
#    exit 1
#fi

#Run bowtie_batch
singularity run $CENTRIFUGE_IMG $@

echo "Done, look in OUT_DIR \"$OUT_DIR\""
echo "Comments to Scott Daniel <scottdaniel@email.arizona.edu>"

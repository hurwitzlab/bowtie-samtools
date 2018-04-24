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
# Some needed functions
#
function lc() { 
    wc -l "$1" | cut -d ' ' -f 1 
}

function HELP() {
    echo "See bowtie_batch.py for help"
    exit 0
}


set -u

#
# Set up defaults for inputs, constants
#
READS_DIR="" #-r | --reads | --reads-dir
INPUT_DB="" #-d | --db | --input-db
INPUT_FMT="fastq" #-f | --fmt | --input-format
INTERLEAVED="FALSE" #-i | --interleaved
READ_TYPES="mixed" #-y | --read-types
DISTANCE="1" #-D | --dist
FILTER=".py" #-x | --exclude
UNPAIR_TERM="unpair" #-u | --unpair-terms
PAIR_TERM="pair" #-p | --pair-terms
KEEP_SAM="FALSE" #-k | --keep-sam
MERGE_OUTPUT="FALSE" #-m | --merge-args
MERGE_NAME="bowtie2-run.sam" #-n | --merge-name
REMOVE_TMP="FALSE" #-z | --remove-tmp
LOG_FN="bowtie2-read-mapping.log" #-l | --log-file
ALIGN_TYPE="end-to-end" #-a | --alignment-type
GLOBAL_PRESETS="sensitive" #-e | --end-to-end-presets
LOCAL_PRESETS="sensitive-local" #-c | --local-presets
NON_DETERMINISTIC="FALSE" #-N | --non-deterministic
TRIM5="0" #-5 | --trim5
TRIM3="0" #-3 |--trim3
MININS="0" #-I | --minins
MAXINS="2000" #-X | --maxins
THREADS="1" #-t | --threads
SING_IMG="bowtie_sam.img" #-S | --sing-img
OUT_DIR="./out_dir" #-O | --out-dir

#Read the arguments
# In case you wanted to check what variables were passed
# echo "flags = $*"

while getopts r:d:f:i:y:D:x:u:p:k:m:n:z:l:a:e:c:N:5:3:I:X:t:S:O:h ARG; do
    case $ARG in
        r)
            READS_DIR=$OPTARG
            ;;
        d)
            INPUT_DB=$OPTARG
            ;;
        f)
            INPUT_FMT=$OPTARG
            ;;
        i)
            INTERLEAVED=$OPTARG
            ;;
        y)
            READ_TYPES=$OPTARG
            ;;
        D)
            DISTANCE=$OPTARG
            ;;
        x)
            FILTER=$OPTARG
            ;;
        u)
            UNPAIR_TERM=$OPTARG
            ;;
        p)
            PAIR_TERM=$OPTARG
            ;;
        k)
            KEEP_SAM=$OPTARG
            ;;
        m)
            MERGE_OUTPUT=$OPTARG
            ;;
        n)
            MERGE_NAME=$OPTARG
            ;;
        z)
            REMOVE_TMP=$OPTARG
            ;;
        l)
            LOG_FN=$OPTARG
            ;;
        a)
            ALIGN_TYPE=$OPTARG
            ;;
        e)
            GLOBAL_PRESETS=$OPTARG
            ;;
        c)
            LOCAL_PRESETS=$OPTARG
            ;;
        N)
            NON_DETERMINISTIC=$OPTARG
            ;;
        5)
            TRIM5=$OPTARG
            ;;
        3)
            TRIM3=$OPTARG
            ;;
        I)
            MININS=$OPTARG
            ;;
        X)
            MAXINS=$OPTARG
            ;;
        t)
            THREADS=$OPTARG
            ;;
        S)
            SING_IMG=$OPTARG
            ;;
        O)
            OUT_DIR=$OPTARG
            ;;
        h)
            HELP
            ;;
        \?) #unrecognized option - show help
            HELP
            ;;
    esac
done
   


#If you have your own launcher setup on stampede2 just point MY_PARAMRUN at it
#this will override the TACC_LAUNCHER...
#PARAMRUN="${MY_PARAMRUN:-$TACC_LAUNCHER_DIR/paramrun}"

#
# Show HELP if no arguments
#
[[ $# -eq 0 ]] && echo "Need some arguments" && HELP

#check for centrifuge image
if [[ ! -e "$SING_IMG" ]]; then
    echo "Missing SING_IMG \"$SING_IMG\""
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
singularity run -B "$HOST":"$GUEST" $SING_IMG $@

echo "Done, look in OUT_DIR \"$OUT_DIR\""
echo "Comments to Scott Daniel <scottdaniel@email.arizona.edu>"

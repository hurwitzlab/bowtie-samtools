#!/bin/bash

#SBATCH -J bowtie2
#SBATCH -A iPlant-Collabs 
#SBATCH -N 12
#SBATCH -n 1
#SBATCH -t 24:00:00
#SBATCH -p normal

# Author: Scott G. Daniel <scottdaniel@email.arizona.edu>

###Uncomment when back on tacc#
echo "#### LOADING TACC-SINGULARITY ####"
module load tacc-singularity 
echo "#### LOADING LAUNCHER ####"
module load launcher

#
# Set up defaults for inputs, constants
#
SING_IMG="bowtie_sam.img"

#
# Some needed functions
#
function lc() { 
    wc -l "$1" | cut -d ' ' -f 1 
}

function HELP() {

    singularity exec $SING_IMG patric_bowtie2.py -h
    
    exit 0
}

#
# Show HELP if no arguments
#
[[ $# -eq 0 ]] && echo "Need some arguments" && HELP

set -u

#parse options
while getopts :g:x:1:2:U:f:O:kn:l:a:e:L:N5:3:I:X:t:A:h ARG; do
    case $ARG in
        g)
            GENOME_DIR="$OPTARG"
            ;;
        x)
            BT2_IDX="$OPTARG"
            ;;
        1)
            M1="$OPTARG"
            ;;
        2)
            M2="$OPTARG"
            ;;
        f)
            INPUT_FMT="$OPTARG"
            ;;
        O)
            OUT_DIR="$OPTARG"
            ;;
        k)
            KEEP_SAM=1
            ;;
        n)
            SAM_NAME="$OPTARG"
            ;;
        l)
            LOGFILE="$OPTARG"
            ;;
        a)
            ALIGNMENT_TYPE="$OPTARG"
            ;;
        e)
            END_TO_END_PRESETS="$OPTARG"
            ;;
        c)
            LOCAL_PRESETS="$OPTARG"
            ;;
        N)
            NON_DETERMINISTIC=1
            ;;
        5)
            TRIM5="$OPTARG"
            ;;
        3)
            TRIM3="$OPTARG"
            ;;
        I)
            MINFRAGLEN="$OPTARG"
            ;;
        X)
            MAXFRAGLEN="$OPTARG"
            ;;
        t)
            THREADS="$OPTARG"
            ;;
        A)
            ADDITIONAL="$OPTARG"
            ;;
        h)
            HELP
            ;;
        :)
            echo ""$OPTARG" requires an argument"
            ;;
        \?) #unrecognized option - show help
            echo "Invalid option "$OPTARG""
            HELP
            ;;
    esac
done
 
#DEBUG
echo "The options are $*"

#It is common practice to call the shift command 
#at the end of your processing loop to remove 
#options that have already been handled from $@.
shift $((OPTIND -1))


#check for centrifuge image
if [[ ! -e "$SING_IMG" ]]; then
    echo "Missing SING_IMG \"$SING_IMG\""
    exit 1
fi


#
# Make it so bowtie is happy
# because the read names will be passed in like so:
# M1="forward_read_1.fastq forward_read_2.fastq"
# and we need:
# M1="forward_read_1.fastq,forward_read_2.fastq"
#

M1=$(echo $M1 | sed 's/ /,/')
M2=$(echo $M2 | sed 's/ /,/')

#Run bowtie_batch
singularity exec $SING_IMG patric_bowtie2.py -g $GENOME_DIR \
  -x $BT2_IDX -1 $M1 -2 $M2 \
  -U $UNPAIRED -f $INPUT_FMT -O $OUT_DIR -k $KEEP_SAM -n $SAM_NAME \
  -l $LOGFILE -a $ALIGNMENT_TYPE -e $END_TO_END_PRESETS -L $LOCAL_PRESETS \
  -N $NON_DETERMINISTIC -5 $TRIM5 -3 $TRIM3 -I $MINFRAGLEN \
  -X $MAXFRAGLEN -t $THREADS -A $ADDITIONAL

echo "Log messages will be in "$OUT_DIR"/bowtie2-read-mapping.log by default"
echo "Comments to Scott Daniel <scottdaniel@email.arizona.edu>"


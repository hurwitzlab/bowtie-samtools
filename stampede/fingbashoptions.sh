#!/usr/bin/env bash

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

echo "M1 = $M1"
echo "M2 = $M2"

M1=$(echo $M1 | sed 's/ /,/')
M2=$(echo $M2 | sed 's/ /,/')

echo "Now for bowtie M1 is $M1"
echo "Now for bowtie M2 is $M2"

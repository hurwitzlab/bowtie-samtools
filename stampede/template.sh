#!/bin/bash

echo "genome-dir \"${GENOME_DIR}\""
echo "bt2_idx \"${BT2_IDX}\""
echo "m1 \"${M1}\""
echo "m2 \"${M2}\""
echo "unpaired \"${UNPAIRED}\""
echo "input_fmt \"${INPUT_FMT}\""
echo "out_dir \"${OUT_DIR}\""
echo "keep_sam \"${KEEP_SAM}\""
echo "sam_name \"${SAM_NAME}\""
echo "logFile \"${LOGFILE}\""
echo "alignment_type \"${ALIGNMENT_TYPE}\""
echo "end_to_end_presets \"${END_TO_END_PRESETS}\""
echo "local_presets \"${LOCAL_PRESETS}\""
echo "non_deterministic \"${NON_DETERMINISTIC}\""
echo "trim5 \"${TRIM5}\""
echo "trim3 \"${TRIM3}\""
echo "minFragLen \"${MINFRAGLEN}\""
echo "maxFragLen \"${MAXFRAGLEN}\""
echo "threads \"${THREADS}\""
echo "additional \"${ADDITIONAL}\""

bash run.sh ${GENOME_DIR} ${BT2_IDX} ${M1} ${M2} ${UNPAIRED} ${INPUT_FMT} ${OUT_DIR} ${KEEP_SAM} ${SAM_NAME} ${LOGFILE} ${ALIGNMENT_TYPE} ${END_TO_END_PRESETS} ${LOCAL_PRESETS} ${NON_DETERMINISTIC} ${TRIM5} ${TRIM3} ${MINFRAGLEN} ${MAXFRAGLEN} ${THREADS} ${ADDITIONAL}

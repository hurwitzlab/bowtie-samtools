#!/bin/bash

echo "genome-dir \"${genome_dir}\""
echo "bt2_idx \"${bt2_idx}\""
echo "m1 \"${m1}\""
echo "m2 \"${m2}\""
echo "unpaired \"${unpaired}\""
echo "input_fmt \"${input_fmt}\""
echo "out_dir \"${out_dir}\""
echo "keep_sam \"${keep_sam}\""
echo "logFile \"${logFile}\""
echo "alignment_type \"${alignment_type}\""
echo "end_to_end_presets \"${end_to_end_presets}\""
echo "local_presets \"${local_presets}\""
echo "non_deterministic \"${non_deterministic}\""
echo "trim5 \"${trim5}\""
echo "trim3 \"${trim3}\""
echo "minFragLen \"${minFragLen}\""
echo "maxFragLen \"${maxFragLen}\""
echo "threads \"${threads}\""
echo "additional \"${additional}\""

bash run.sh ${genome_dir} ${bt2_idx} ${m1} ${m2} ${unpaired} ${input_fmt} ${out_dir} ${keep_sam} ${logFile} ${alignment_type} ${end_to_end_presets} ${local_presets} ${non_deterministic} ${trim5} ${trim3} ${minFragLen} ${maxFragLen} ${threads} ${additional}

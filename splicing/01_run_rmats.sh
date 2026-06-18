cd splicing

# get list of bams per condition

ls input_data/bams/mCN11*bam input_data/bams/mCN12*bam | paste -sd "," > ctrl_bams.txt
ls input_data/bams/mCN13*bam input_data/bams/mCN14*bam | paste -sd "," > caltrap_NA_bams.txt
ls input_data/bams/mCN15*bam input_data/bams/mCN16*bam | paste -sd "," > caltrap_SR_bams.txt

# run

rmats_path=<path to rMATS binary>
gtf=input_data/gencode.vM35.annotation.gtf # make sure this has been unzipped

# ctrl vs. caltrap NA
python "${rmats_path}/rmats.py" \
    --b1 ctrl_bams.txt \
    --b2 caltrap_NA_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --variable-read-length \
    --readLength 100 \
    --nthread 20 \
    --od data/rmats/ctrl_vs_caltrap_NA \
    --tmp data/rmats/ctrl_vs_caltrap_NA

# ctrl vs. caltrap SR
python "${rmats_path}/rmats.py" \
    --b1 ctrl_bams.txt \
    --b2 caltrap_SR_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --variable-read-length \
    --readLength 100 \
    --nthread 20 \
    --od data/rmats/ctrl_vs_caltrap_SR \
    --tmp data/rmats/ctrl_vs_caltrap_SR

# caltrap NA vs. caltrap SR
python "${rmats_path}/rmats.py" \
    --b1 caltrap_NA_bams.txt \
    --b2 caltrap_SR_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --readLength 100 \
    --variable-read-length \
    --nthread 20 \
    --od data/rmats/caltrap_NA_vs_SR \
    --tmp data/rmats/caltrap_NA_vs_SR
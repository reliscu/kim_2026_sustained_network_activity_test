cd splicing

# get list of bams per condition

ls input_data/bams/mCN11*bam input_data/bams/mCN12*bam | paste -sd "," > ctrl_bams_batch2.txt
ls input_data/bams/mCN13*bam input_data/bams/mCN14*bam | paste -sd "," > caltrap_naive_bams.txt
ls input_data/bams/mCN15*bam input_data/bams/mCN16*bam | paste -sd "," > caltrap_AR_bams.txt

# run

rmats_path=<path to rMATS binary>
gtf=input_data/gencode.vM35.annotation.gtf # make sure this has been unzipped

# ctrl vs. caltrap naive
python "${rmats_path}/rmats.py" \
    --b1 ctrl_bams_batch2.txt \
    --b2 caltrap_naive_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --variable-read-length \
    --readLength 100 \
    --nthread 20 \
    --od data/rmats/ctrl_vs_naive \
    --tmp data/rmats/ctrl_vs_naive

# ctrl vs. caltrap AR
python "${rmats_path}/rmats.py" \
    --b1 ctrl_bams_batch2.txt \
    --b2 caltrap_AR_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --variable-read-length \
    --readLength 100 \
    --nthread 20 \
    --od data/rmats/ctrl_vs_AR \
    --tmp data/rmats/ctrl_vs_AR

# caltrap naive vs. caltrap AR
python "${rmats_path}/rmats.py" \
    --b1 caltrap_naive_bams.txt \
    --b2 caltrap_AR_bams.txt \
    --gtf "$gtf" \
    -t paired \
    --readLength 100 \
    --variable-read-length \
    --nthread 20 \
    --od data/rmats/naive_vs_AR \
    --tmp data/rmats/naive_vs_AR
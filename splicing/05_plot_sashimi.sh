# the command below uses modified MISO code
# to apply the required changes, replace the following file in your MISO installation:
#   <miso_install_dir>/sashimi_plot/plot_utils/plot_gene.py
# with the provided version at:
#   splicing/code/plot_gene.py
#
# the typical install path is:
#   $HOME/anaconda3/lib/python3.11/site-packages/rmats2sashimiplot-<version>-py<pyver>.egg/MISO/misopy/
# but this will vary depending on your Python version and rmats2sashimiplot version

cd splicing 

comparison="ctrl_vs_naive"
type="SE" # rmats splicing event type
events_file="data/rmats_events_of_interest_${comparison}.txt" # use `02_subset_events_for_plotting.ipynb` to generate these files; all entries should be the same splicing event type (e.g. SE)

# condition 1
b1_file="ctrl_bams.txt" # list of bams per condition (generated in `01_run_rmats.sh`)
l1_label="Control" # modify this (and the grouping file) to change how condition name appears on plot (must match name in grouping file) 

# condition 2
b2_file="caltrap_naive_bams.txt" # list of bams per condition (generated in `01_run_rmats.sh`)
l2_label="Cal-TRAP naive" # modify this (and the grouping file) to change how condition name appears on plot (must match name in grouping file)

# group samples
grouping_file="input_data/grouping_naive.gf" # puts all samples from a given condition into 1 plot (instead of 1 plot per sample)

# to change intron:exon size ratio: use `--intron_s` flag

rmats2sashimiplot \
    --b1 "$b1_file" \
    --b2 "$b2_file" \
    --l1 "$l1_label" \
    --l2 "$l2_label" \
    --event-type "$type" \
    --group-info "$grouping_file" \
    --intron_s 20 \
    -e "$events_file"\
    -o figures 
#!/bin/sh
srrs_list=$1
bin/collect_taxids.sh $srrs_list data/traces > data/taxids.txt
bin/compare_taxids.py data/taxids.txt > data/dists/taxids_dists.txt
sort -n -k 3 -t ' ' data/dists/taxids_dists.txt | bin/cluster.py > data/clusters/taxids_clusters.txt

tail -n +2 info/CoV_run_counts.tsv | grep -f $srrs_list > data/cov/CoV_runs_counts.tsv.subsample
bin/pair_dist_cov.py data/cov/CoV_runs_counts.tsv.subsample > data/dists/cov_dists.txt
sort -n -k 3 -t ' ' data/dists/cov_dists.txt | bin/cluster.py > data/clusters/cov_clusters.txt

export TMPDIR=/home/hollowayem/srrs-data3/tmp # Replace as appropriate
bin/dl_lzjd_dist.sh $srrs_list data/ngs/raw/ data/lzjd/sdbfs.txt > data/dists/ngs_lzjd_dists.txt
sort -n -r -k 3 -t '|' data/dists/ngs_lzjd_dists.txt | bin/cluster.py > data/clusters/ngs_lzjd_clusters.txt

ls data/ngs/raw/* > data/mash/input_files.txt
bin/mash.exe sketch -l data/mash/input_files.txt -k 16 -s 1024 -o data/mash/sketches
bin/mash.exe dist data/mash/sketches.msh data/mash/sketches.msh > data/dists/ngs_mash_dists.txt
sort -n -k 3 data/dists/ngs_mash_dists.txt | bin/cluster.py > data/clusters/ngs_mash_clusters.txt

echo comparing clusters
bin/relevant_rand_tests.sh

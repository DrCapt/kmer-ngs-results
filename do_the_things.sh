#!/bin/sh
srrs_list=info/srrs_100M_200M.txt
if [ ! -f data/taxids.txt ]
then
  bin/collect_taxids.sh $srrs_list data/traces > data/taxids.txt
fi
if [ ! -f data/dists/taxids_dists.txt ]
then
  bin/compare_taxids.py data/taxids.txt > data/dists/taxids_dists.txt
fi
if [ ! -f data/clusters/taxids_clusters.txt ]
then
  sort -n -k 3 -t ' ' data/dists/taxids_dists.txt | bin/cluster.py > data/clusters/taxids_clusters.txt
fi

if [ ! -f data/cov/CoV_runs_counts.tsv.subsample ]
then
  tail -n +2 info/CoV_run_counts.tsv | grep -f $srrs_list > data/cov/CoV_runs_counts.tsv.subsample
fi
if [ ! -f data/dists/cov_dists.txt ]
then
  bin/pair_dist_cov.py data/cov/CoV_runs_counts.tsv.subsample > data/dists/cov_dists.txt
fi
if [ ! -f data/clusters/cov_clusters.txt ]
then
  sort -n -k 3 -t ' ' data/dists/cov_dists.txt | bin/cluster.py > data/clusters/cov_clusters.txt
fi

export TMPDIR=/home/hollowayem/srrs-data3/tmp # Replace as appropriate
if [ ! -f data/dists/ngs_lzjd_dists.txt ]
then
  bin/dl_lzjd_dist.sh $srrs_list data/ngs/raw/ data/lzjd/sdbfs.txt > data/dists/ngs_lzjd_dists.txt
fi
if [ ! -f data/clusters/ngs_lzjd_clusters.txt ]
then
  sort -n -r -k 3 -t '|' data/dists/ngs_lzjd_dists.txt | bin/subsample.py info/srrs_100M_200M.txt '\|' | bin/cluster.py > data/clusters/ngs_lzjd_clusters.txt
fi

if [ ! -f data/mash/input_files.txt ]
then
  ls data/ngs/raw/* > data/mash/input_files.txt
fi
if [ ! -f data/mash/sketches.msh ]
then 
  bin/mash.exe sketch -l data/mash/input_files.txt -k 18 -s 1024 -o data/mash/sketches
fi
if [ ! -f data/dists/ngs_mash_dists.txt ]
then
  bin/mash.exe dist data/mash/sketches.msh data/mash/sketches.msh > data/dists/ngs_mash_dists.txt
fi
if [ ! -f data/clusters/ngs_mash_clusters.txt ]
then
  sort -n -k 3 data/dists/ngs_mash_dists.txt | bin/subsample.py info/srrs_100M_200M.txt '\t' | bin/cluster.py > data/clusters/ngs_mash_clusters.txt
fi

echo comparing clusters
bin/relevant_rand_tests.sh

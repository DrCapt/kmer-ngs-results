#!/bin/sh

echo
echo 'randomness test on clusters file:' $2
echo 'number of experiments:' $3
echo |> data/rand/rand_results.txt
for i in `seq $3`
do
  shuf $1 | bin/cluster.py > data/clusters/rand.clusters
  cat $2 | bin/score_cluster.py data/clusters/rand.clusters >> data/rand/rand_results.txt
done
Rscript bin/rand_calc.r $4

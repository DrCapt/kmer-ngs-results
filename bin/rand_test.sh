#!/bin/sh

echo $1 $2 $3 $4
echo |> data/rand/rand_results.txt
for i in `seq $3`
do
  shuf $1 > $1.rand
  cat $1.rand | bin/cluster.py > $1.rand.clusters
  cat $2 | bin/score_cluster.py $1.rand.clusters >> data/rand/rand_results.txt
done
Rscript bin/rand_calc.r $4

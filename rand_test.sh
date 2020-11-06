#!/bin/sh

echo $1 $2 $3 $4
echo |> rand_results.txt
for i in `seq $3`
do
  shuf $1 > $1.rand
  cat $1.rand | python3 code/cluster.py -1 > $1.rand.clusters
  cat $2 | python3 code/score_cluster.py $1.rand.clusters >> rand_results.txt
done
Rscript rand_calc.r $4

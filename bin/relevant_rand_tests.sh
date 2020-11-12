#!/bin/sh
dists=data/dists/cov_dists.txt
clusters1=data/clusters/cov_clusters.txt
clusters2=data/clusters/taxids_clusters.txt
clusters3=data/clusters/ngs_mash_clusters.txt
clusters4=data/clusters/ngs_lzjd_clusters.txt

exp_count=100

echo Begin comparison
c1c2=$(cat $clusters1 | bin/score_cluster.py $clusters2)
echo comparing clusters:
echo - $clusters1 
echo - $clusters2 
echo normalized mutual information score: $c1c2
bin/rand_test.sh $dists $clusters2 $exp_count $c1c2
echo End comparison
echo
echo Begin comparison
c1c3=$(cat $clusters1 | bin/score_cluster.py $clusters3)
echo comparing clusters:
echo - $clusters1 
echo - $clusters3 
echo normalized mutual information score: $c1c3
bin/rand_test.sh $dists $clusters3 $exp_count $c1c3
echo End comparison
echo
echo Begin comparison
c1c4=$(cat $clusters1 | bin/score_cluster.py $clusters4)
echo comparing clusters:
echo - $clusters1 
echo - $clusters4 
echo normalized mutual information score: $c1c4
bin/rand_test.sh $dists $clusters4 $exp_count $c1c4
echo End comparison
echo
echo Begin comparison
c2c1=$(cat $clusters2 | bin/score_cluster.py $clusters1)
echo comparing clusters:
echo - $clusters2 
echo - $clusters1 
echo normalized mutual information score: $c2c1
bin/rand_test.sh $dists $clusters1 $exp_count $c2c1
echo End comparison
echo
echo Begin comparison
c2c3=$(cat $clusters2 | bin/score_cluster.py $clusters3)
echo comparing clusters:
echo - $clusters2 
echo - $clusters3 
echo normalized mutual information score: $c2c3
bin/rand_test.sh $dists $clusters3 $exp_count $c2c3
echo End comparison
echo
echo Begin comparison
c2c4=$(cat $clusters2 | bin/score_cluster.py $clusters4)
echo comparing clusters:
echo - $clusters2 
echo - $clusters4 
echo normalized mutual information score: $c2c4
bin/rand_test.sh $dists $clusters4 $exp_count $c2c4
echo End comparison
echo
echo Begin comparison
c3c1=$(cat $clusters3 | bin/score_cluster.py $clusters1)
echo comparing clusters:
echo - $clusters3 
echo - $clusters1 
echo normalized mutual information score: $c3c1
bin/rand_test.sh $dists $clusters1 $exp_count $c3c1
echo End comparison
echo
echo Begin comparison
c3c2=$(cat $clusters3 | bin/score_cluster.py $clusters2)
echo comparing clusters:
echo - $clusters3 
echo - $clusters2 
echo normalized mutual information score: $c3c2
bin/rand_test.sh $dists $clusters2 $exp_count $c3c2
echo End comparison
echo
echo Begin comparison
c3c4=$(cat $clusters3 | bin/score_cluster.py $clusters4)
echo comparing clusters:
echo - $clusters3 
echo - $clusters4 
echo normalized mutual information score: $c3c4
bin/rand_test.sh $dists $clusters4 $exp_count $c3c4
echo End comparison
echo
echo Begin comparison
c4c1=$(cat $clusters4 | bin/score_cluster.py $clusters1)
echo comparing clusters:
echo - $clusters4 
echo - $clusters1 
echo normalized mutual information score: $c4c1
bin/rand_test.sh $dists $clusters1 $exp_count $c4c1
echo End comparison
echo
echo Begin comparison
c4c2=$(cat $clusters4 | bin/score_cluster.py $clusters2)
echo comparing clusters:
echo - $clusters4 
echo - $clusters2 
echo normalized mutual information score: $c4c2
bin/rand_test.sh $dists $clusters2 $exp_count $c4c2
echo End comparison
echo
echo Begin comparison
c4c3=$(cat $clusters4 | bin/score_cluster.py $clusters3)
echo comparing clusters:
echo - $clusters4 
echo - $clusters3 
echo normalized mutual information score: $c4c3
bin/rand_test.sh $dists $clusters3 $exp_count $c4c3
echo End comparison
echo

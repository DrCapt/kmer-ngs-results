#!/bin/sh
clusters1=data/clusters/cov_clusters.txt
clusters2=data/clusters/taxids_clusters.txt
clusters3=data/clusters/ngs_mash_clusters.txt
clusters4=data/clusters/ngs_lzjd_clusters.txt

exp_count=100

c1c2=$(cat $clusters1 | bin/score_cluster.py $clusters2)
echo $clusters1:$clusters3:$c1c2
bin/rand_test.sh $clusters1 $clusters2 $exp_count $c1c2
c1c3=$(cat $clusters1 | bin/score_cluster.py $clusters3)
echo $clusters1:$clusters4:$c1c3
bin/rand_test.sh $clusters1 $clusters3 $exp_count $c1c3
c1c4=$(cat $clusters1 | bin/score_cluster.py $clusters4)
echo $clusters2:$clusters1:$c1c4
bin/rand_test.sh $clusters1 $clusters4 $exp_count $c1c4
c2c1=$(cat $clusters2 | bin/score_cluster.py $clusters1)
echo $clusters2:$clusters3:$c2c1
bin/rand_test.sh $clusters2 $clusters1 $exp_count $c2c1
c2c3=$(cat $clusters2 | bin/score_cluster.py $clusters3)
echo $clusters2:$clusters4:$c2c3
bin/rand_test.sh $clusters2 $clusters3 $exp_count $c2c3
c2c4=$(cat $clusters2 | bin/score_cluster.py $clusters4)
echo $clusters3:$clusters1:$c2c4
bin/rand_test.sh $clusters2 $clusters4 $exp_count $c2c4
c3c1=$(cat $clusters3 | bin/score_cluster.py $clusters1)
echo $clusters3:$clusters2:$c3c1
bin/rand_test.sh $clusters3 $clusters1 $exp_count $c3c1
c3c2=$(cat $clusters3 | bin/score_cluster.py $clusters2)
echo $clusters3:$clusters4:$c3c2
bin/rand_test.sh $clusters3 $clusters2 $exp_count $c3c2
c3c4=$(cat $clusters3 | bin/score_cluster.py $clusters4)
echo $clusters4:$clusters1:$c3c4
bin/rand_test.sh $clusters3 $clusters4 $exp_count $c3c4
c4c1=$(cat $clusters4 | bin/score_cluster.py $clusters1)
echo $clusters4:$clusters2:$c4c1
bin/rand_test.sh $clusters4 $clusters1 $exp_count $c4c1
c4c2=$(cat $clusters4 | bin/score_cluster.py $clusters2)
echo $clusters4:$clusters3:$c4c2
bin/rand_test.sh $clusters4 $clusters2 $exp_count $c4c2
c4c3=$(cat $clusters4 | bin/score_cluster.py $clusters3)
echo $clusters1:$clusters2:$c4c3
bin/rand_test.sh $clusters4 $clusters3 $exp_count $c4c3

## Overview
This repo contains all the necessary scripts to cluster genomic datasets gathered from potential sources of SARS-CoV2.

Two different methods are used to cluster the datasets: Mash and LZJD.  Both are kmer (ngram) based.  Mash uses fixed length kmers, while LZJD uses adaptive kmer lengths derived using the Lempel-Ziv 78 compression algorithm.

The clusters are compared to each other to see if both methods arrive at similar results.  They are also compared to two 'gold standard' clusters.  

All the clusters can be found in the directory `data/clusters`.  The clusters file format consists of the dataset ID and the cluster ID, separated by a colon.  For example, here we have ten different genetic datasets assigned to five different clusters.
```
kmer-ngs-results$ head data/clusters/cov_clusters.txt
SRR6994420:0
SRR6994268:0
ERR963091:1
ERR873315:1
SRR1168920:2
SRR1168917:2
ERR963003:3
ERR963051:3
SRR1168929:3
SRR8988506:4
```

We can also see there are 97 clusters altogether in the `cov_clusters.txt` file.
```
kmer-ngs-results$ cut -f 2 -d ':' data/clusters/ngs_lzjd_clusters.txt | sort | uniq | wc -l
97
```

The first clusters standard is labeled `cov_clusters.txt`.  The clusters are generated using NCBI reference kmers for a variety of coronavidae (types of coronaviruses).  These kmers only detect the presence of coronavidae genetic material, not other kinds of genetic material.  

The second clusters standard is labeled `taxid_clusters.txt`.  The clusters are generated using the kmer signature for the organism from which the genetic material was taken.

Altogether, there are four cluster sets in the following files.
```
kmer-ngs-results$ ls -1 data/clusters/
cov_clusters.txt
ngs_lzjd_clusters.txt
ngs_mash_clusters.txt
taxids_clusters.txt
```

To compare the clusters, I used a metric called normalized mutual information (NMI).  The formula for this metric is the following, and takes values between 0 and 1 inclusive.
```
NMI(X, Y) = 2*I(X;I)/(H(X)+H(Y))
```

The metric is symmetric, and all six pairwise comparisons are calculated between the four clusters.

In addition, to make sure the NMI scores are not attributable to chance, I also calculate the NMI between randomly generated clusters and each of the four official cluster sets.  I do this comparison with 100 different random clusters for each official set of clusters, and take the minimum and maximum NMI values to get a 99th percentile randomness threshold.

To generate all the official comparisons and the randomness thresholds run the script `./bin/relevant_rand_tests.sh`.


Here are the results from running the comparisons.  For example, the top comparison is between the `cov_clusters.txt` and `taxids_clusters.txt` files.  The comparison generates a NMI score of 0.57.  It is a little tricky since we can see it is lower than the randomness threshold for `cov_clusters.txt` (0.70) yet higher than the randomness threshold for `taxids_clusters.txt` (0.44).  So, we need to ensure the comparison value is higher than the *smallest* NMI maximum threshold, which in this case is 0.44.
```
Begin comparison
comparing clusters:
- data/clusters/cov_clusters.txt
- data/clusters/taxids_clusters.txt
normalized mutual information score: 0.5727841615905445

randomness test on clusters file: data/clusters/cov_clusters.txt
number of experiments: 100
value to test: 0.572784161590544
successful tests: 0%
minimum value achieved from random: 0.666525614083006
maximum value achieved from random: 0.704830888561635

randomness test on clusters file: data/clusters/taxids_clusters.txt
number of experiments: 100
value to test: 0.572784161590544
successful tests: 100%
minimum value achieved from random: 0.400872232991801
maximum value achieved from random: 0.443932378188317
End comparison

Begin comparison
comparing clusters:
- data/clusters/cov_clusters.txt
- data/clusters/ngs_mash_clusters.txt
normalized mutual information score: 0.6971941898091356

randomness test on clusters file: data/clusters/cov_clusters.txt
number of experiments: 100
value to test: 0.697194189809136
successful tests: 99%
minimum value achieved from random: 0.6579536075697
maximum value achieved from random: 0.702806558604803

randomness test on clusters file: data/clusters/ngs_mash_clusters.txt
number of experiments: 100
value to test: 0.697194189809136
successful tests: 100%
minimum value achieved from random: 0.581117079173818
maximum value achieved from random: 0.620769214574017
End comparison

Begin comparison
comparing clusters:
- data/clusters/cov_clusters.txt
- data/clusters/ngs_lzjd_clusters.txt
normalized mutual information score: 0.7132341347011804

randomness test on clusters file: data/clusters/cov_clusters.txt
number of experiments: 100
value to test: 0.71323413470118
successful tests: 100%
minimum value achieved from random: 0.662964871393632
maximum value achieved from random: 0.703295321627451

randomness test on clusters file: data/clusters/ngs_lzjd_clusters.txt
number of experiments: 100
value to test: 0.71323413470118
successful tests: 100%
minimum value achieved from random: 0.622262492442124
maximum value achieved from random: 0.657957369326849
End comparison

Begin comparison
comparing clusters:
- data/clusters/taxids_clusters.txt
- data/clusters/ngs_mash_clusters.txt
normalized mutual information score: 0.6394537387587363

randomness test on clusters file: data/clusters/taxids_clusters.txt
number of experiments: 100
value to test: 0.639453738758736
successful tests: 100%
minimum value achieved from random: 0.399463046051268
maximum value achieved from random: 0.442695012504041

randomness test on clusters file: data/clusters/ngs_mash_clusters.txt
number of experiments: 100
value to test: 0.639453738758736
successful tests: 100%
minimum value achieved from random: 0.575944259903585
maximum value achieved from random: 0.617589690367174
End comparison

Begin comparison
comparing clusters:
- data/clusters/taxids_clusters.txt
- data/clusters/ngs_lzjd_clusters.txt
normalized mutual information score: 0.6235055111761345

randomness test on clusters file: data/clusters/taxids_clusters.txt
number of experiments: 100
value to test: 0.623505511176135
successful tests: 100%
minimum value achieved from random: 0.394840477067155
maximum value achieved from random: 0.444208998204095

randomness test on clusters file: data/clusters/ngs_lzjd_clusters.txt
number of experiments: 100
value to test: 0.623505511176135
successful tests: 5%
minimum value achieved from random: 0.611234226342472
maximum value achieved from random: 0.652191538433798
End comparison

Begin comparison
comparing clusters:
- data/clusters/ngs_mash_clusters.txt
- data/clusters/ngs_lzjd_clusters.txt
normalized mutual information score: 0.7779869029649207

randomness test on clusters file: data/clusters/ngs_mash_clusters.txt
number of experiments: 100
value to test: 0.777986902964921
successful tests: 100%
minimum value achieved from random: 0.578288109622305
maximum value achieved from random: 0.615011796074542

randomness test on clusters file: data/clusters/ngs_lzjd_clusters.txt
number of experiments: 100
value to test: 0.777986902964921
successful tests: 100%
minimum value achieved from random: 0.615740296934087
maximum value achieved from random: 0.661032904106201
End comparison
```

## Details on Method
The top level script to download all necessary data, calculate distances, create clusters, and perform comparisons is the script:
```
./do_the_things.sh
```
If files are already generated for a step, then `do_the_things.sh` will skip that step.  If you want to redo a stage in the script (warning: this can take up to an hour to run), then find the file referenced in the conditional and delete it.  Don't worry if you make a mistake since you can alway reset the repo.
For example, to rerun the generation of the `taxids_clusters.txt` file, delete it at `data/clusters/taxids_clusters.txt`.  You can figure this out by looking at the condition at the top of the section in `do_the_things.sh`.
```
if [ ! -f data/clusters/cov_clusters.txt ] || [ ! -f data/dists/cov_dists.txt ]
then
...
```

The very resource consuming stages are downloading the genetic datasets from Google Cloud Storage (GCS), which will use about 70G of storage space, and then indexing the datasets.  This takes about an hour of CPU time for LZJD and 20 minutes for Mash on the `n1-standard-8` Google Cloud Virtual Machine.

There are a number of helper scripts, but the important scripts are these:
```
./bin/cluster.py
./bin/score_cluster.py
```

The names are descriptive.  The first script takes a sorted list of distance triples and uses 1 Nearest Neighbor clustering to create the clusters.
The second script calculates the normalized mutual information between two clusters.



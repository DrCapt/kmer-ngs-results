#!/bin/sh
for srr in `cat mash.srrs_100_200M.txt`
do 
	gsutil cp gs://research-sra-cloud-pipeline-experiment-lzjd-cov2/$srr.fna sdbfs.full/
done
java -cp jlzjd.jar com.edwardraff.jlzjd.Main -r sdbfs.full/ -o sdbfs.full.sdbfs
java -cp jlzjd.jar com.edwardraff.jlzjd.Main -t 0 -c sdbfs.full.sdbfs | sort -n -r -k 3 -t '|' > sdbfs.full.sdbfs.mash.srrs_100_200M.pairwise.sorted.rev

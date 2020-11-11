#!/bin/sh
for srr in `cat $1`
do 
	gsutil cp gs://research-sra-cloud-pipeline-experiment-lzjd-cov2/$srr.fna $2
done
java -cp bin/jlzjd.jar com.edwardraff.jlzjd.Main -r $2 -o $3
java -cp bin/jlzjd.jar com.edwardraff.jlzjd.Main -t 0 -c $3

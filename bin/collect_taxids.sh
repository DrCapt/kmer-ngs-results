#!/bin/sh

for srr in `cat $1`
do
	wget -O $2/$srr.xml https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=$srr\&retmode=xml
	echo -n $srr,
	xmllint --format $2/$srr.xml | grep species | tr -d '[' | tr -d ']' | sed -r 's/.*tax_id="([0-9]+)".*name="([A-Za-z0-9. -]+)".*total_count="([0-9]+)".*/\1,"\2",\3/g' | sort -rn -k 3 -t ',' | head -n 1
done

#!/bin/sh
./rand_test.sh srrs-data3/mash.srrs_100_200M.pairwise.results.txt.sorted srrs-data3/sdbfs.full.sdbfs.mash.srrs_100_200M.pairwise.sorted.rev.processed.clusters 1000 0.68
./rand_test.sh srrs-data3/mash.srrs_100_200M.pairwise.results.txt.sorted srrs-data3/cov.srrs_100_200M.pairwise.results.txt.sorted.clusters 1000 0.68
./rand_test.sh srrs-data3/sdbfs.full.sdbfs.mash.srrs_100_200M.pairwise.sorted.rev.processed srrs-data3/mash.srrs_100_200M.pairwise.results.txt.sorted.clusters 1000 0.68
./rand_test.sh srrs-data3/sdbfs.full.sdbfs.mash.srrs_100_200M.pairwise.sorted.rev.processed srrs-data3/cov.srrs_100_200M.pairwise.results.txt.sorted.clusters 1000 0.68
./rand_test.sh srrs-data3/cov.srrs_100_200M.pairwise.results.txt.sorted srrs-data3/mash.srrs_100_200M.pairwise.results.txt.sorted.clusters 1000 0.68
./rand_test.sh srrs-data3/cov.srrs_100_200M.pairwise.results.txt.sorted srrs-data3/sdbfs.full.sdbfs.mash.srrs_100_200M.pairwise.sorted.rev.processed.clusters 1000 0.68
./rand_test.sh srrs-data3/cov.srrs_100_200M.pairwise.results.txt.sorted srrs-data3/taxids.pairwise.sorted.clusters 1000 0.5

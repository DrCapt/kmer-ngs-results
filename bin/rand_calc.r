rrslts <- read.table('data/rand/rand_results.txt')
test_val <- as.numeric(commandArgs(trailingOnly=TRUE)[1])
paste(sum(rrslts[,1] < test_val)/length(rrslts[,1]), max(rrslts[,1]), test_val)

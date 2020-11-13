rrslts <- read.table('data/rand/rand_results.txt')
test_val <- as.numeric(commandArgs(trailingOnly=TRUE)[1])
cat(paste('value to test: ', test_val, '\n', 'successful tests: ', paste(sum(rrslts[,1] < test_val)/length(rrslts[,1])*100, '%', sep=''), '\n', 'minimum value achieved from random: ', min(rrslts[,1]), '\n', 'maximum value achieved from random: ', max(rrslts[,1]), '\n', sep=''))

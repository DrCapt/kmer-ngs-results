#!/usr/bin/python3
import sys

rand_results = [float(result_str) for result_str in open('data/rand/rand_results.txt').read().splitlines()]
test_val = float(sys.argv[1])
print('value to test: ', test_val)
success = sum([result < test_val for result in rand_results])
print('successful tests: ', success/float(len(rand_results))*100, '%')
print('minimum random test value: ', min(rand_results))
print('maximum random test value: ', max(rand_results))

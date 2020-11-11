#!/usr/bin/python3
import sys 
from itertools import combinations

srr_taxid = {line.strip().split(',')[0]:line.strip().split(',')[1] for line in open(sys.argv[1]).read().splitlines() if len(line.split(',')) > 1}

for srrA, srrB in combinations(srr_taxid.keys(), 2):
    if srr_taxid[srrA] == srr_taxid[srrB]:
        print(srrA,srrB,0)
    else:
        print(srrA,srrB,1)

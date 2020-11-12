#!/usr/bin/python3
import sys
import re

whitelist = set(open(sys.argv[1]).read().splitlines())
record_splitter = re.compile(sys.argv[2])
field_splitter = re.compile('[./]')
for line in sys.stdin:
    srr1_field, srr2_field, dist = record_splitter.split(line.strip())[:3]
    srr1_set = set(field_splitter.split(srr1_field)) & whitelist
    if len(srr1_set) > 0:
        srr1 = list(srr1_set)[0]
        srr2_set = set(field_splitter.split(srr2_field)) & whitelist
        if len(srr2_set) > 0:
            srr2 = list(srr2_set)[0]
            if not srr1 == srr2:
                print(srr1, srr2, dist)

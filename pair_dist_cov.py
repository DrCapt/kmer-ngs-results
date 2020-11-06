import sys
import itertools

metadata = {}
srr_tax_ids = {}
tax_ids = set()
for i, line in enumerate(open(sys.argv[1]).readlines()):
    if i < 1: continue
    srr, tax_id, _, cnt, _ = line.split(',')
    metadata[(srr, tax_id)] = int(cnt)
    srr_tax_ids[srr] = srr_tax_ids.get(srr, set()) | set([tax_id])
    tax_ids.add(tax_id)

for srr1, srr2 in itertools.combinations(srr_tax_ids.keys(), 2):
    dist = 0
    for tax_id in srr_tax_ids[srr1] | srr_tax_ids[srr2]:
        tax_id_cnt1 = metadata.get((srr1, tax_id), 0)
        tax_id_cnt2 = metadata.get((srr2, tax_id), 0)
        dist += abs(tax_id_cnt1 - tax_id_cnt2)
    print(srr1 + ' ' + srr2 + ' ' + str(dist))

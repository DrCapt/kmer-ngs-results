#!/usr/bin/python3
import sys
from math import log

def parse_cluster(lines, whitelist):
    cluster_items = {}
    items_cluster = {}
    for line in lines:
        item, cluster = line.strip().split(':')
        items_cluster[item] = cluster
        cluster_items[cluster] = cluster_items.get(cluster, set()) | set([item])
    clusters = {}
    for item, cluster in items_cluster.items():
        if item in whitelist:
            clusters[item] = cluster_items[cluster]
    return clusters

def ent(p):
    if p == 0 or p == 1: return 0
    return -p*log(p,2)

lines = None
whitelist = None

ref_clusters = None
with open(sys.argv[1]) as f:
    lines = f.read().splitlines()

ref_items = [item for line in lines for item in line.split(':')]
whitelist = set(ref_items)
ref_clusters = parse_cluster(lines, whitelist)

lines = sys.stdin.read().splitlines()
gen_items = [item for line in lines for item in line.split(':')]
gen_clusters = parse_cluster(lines, whitelist)

H_X = 0
total = len(ref_clusters)
for cl in set([tuple(v) for v in ref_clusters.values()]):
    p = len(cl)/float(total)
    e = ent(p)
    H_X += e

H_Y = 0
H_XlY = 0
total2 = 0
for gen_cl in set([tuple(v) for v in gen_clusters.values()]):
    p = len(gen_cl)/float(total)
    H_Y += ent(p)

    cnd_clusters = {}
    for item in gen_cl:
        ref_cl = ref_clusters[item]
        cnd_clusters[tuple(ref_cl)] = cnd_clusters.get(tuple(ref_cl), set()) | set([item])
    cH = 0
    for cnd_cl in cnd_clusters.values():
        p = len(cnd_cl)/float(len(gen_cl))
        e = ent(p)
        cH += e
    p = len(gen_cl)/float(total)
    total2 += len(gen_cl)
    cH *= p
    H_XlY += cH

ref_cnt = sum([len(cl) for cl in ref_clusters])
gen_cnt = sum([len(cl) for cl in gen_clusters])

NMI = 0
if H_X+H_Y > 0:
    NMI = 2*(H_X-H_XlY)/(H_X+H_Y)
print(NMI)

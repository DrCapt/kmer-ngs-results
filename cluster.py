import sys
import re

def nearest_neighbor_cluster(triplets):
    for a, b, d in triplets:
        if not a in index:
            cluster = index.get(b, set())
            cluster.update([a, b])
            index[a] = cluster
        if not b in index:
            cluster = index.get(a, set())
            cluster.update([a, b])
            index[b] = cluster
    return set(tuple(cluster) for cluster in index.values())

threshold = int(sys.argv[1])
index = {}
closed = set()
for line in sys.stdin:
    if len(line.split()) < 2:
        continue
    a, b = line.split()[:2]
    closed.add(a)
    closed.add(b)
    if not a in index:
        cluster = index.get(b, set())
        cluster.update([a, b])
        index[a] = cluster
    if not b in index:
        cluster = index.get(a, set())
        cluster.update([a, b])
        index[b] = cluster
    if len(closed) >= threshold and threshold > 0: break

clusters = set([tuple(clstr) for clstr in index.values()])
for i, clstr in enumerate(clusters):
    for item in clstr:
        print(item + ':' + str(i))

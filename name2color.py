#!/usr/bin/env python3
import sys
import hashlib
# add your favorite color code (256) here as candidates
colors = [
    63, 64, 65, 68, 103, 107,
    166, 168, 172, 208, 203,
    160, 161, 167, 137, 131
]
h = hashlib.sha1(sys.argv[1].encode('utf-8')).digest()
print("colour{}".format(colors[h[0] % len(colors)]))

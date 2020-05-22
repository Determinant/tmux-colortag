#!/usr/bin/env python
import sys
import hashlib
# add your favorite color code (256) here as candidates
colors = [
    63, 64, 65, 68, 103, 107,
    166, 168, 172, 208, 203,
    160, 161, 167, 137, 131
]
h = hashlib.sha1(sys.argv[1].encode('utf-8')).digest()
if sys.version_info.major == 3:
    hn = int.from_bytes(h, byteorder='big')
else:
    hn = 0
    for b in bytearray(h):
        hn = hn * 256 + int(b)
print("colour{}".format(colors[hn % len(colors)]))

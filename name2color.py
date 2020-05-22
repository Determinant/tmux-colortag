#!/usr/bin/env python
import argparse
import os
import sys
import hashlib
import pickle


def warn(msg):
    sys.stderr.write(msg + '\n')


def error(msg):
    print("ColorTag: {}\n".format(msg))


saved_state = os.path.expanduser("~/.tmux-colortag.state")
# add your favorite color code (256) here as candidates
colors = [
    63, 64, 65, 68, 103, 107,
    166, 168, 172, 208, 203,
    160, 161, 167, 137, 131
]

parser = argparse.ArgumentParser(description='Maps tmux window tags to colors.')
parser.add_argument('idx', type=int, help='index of the window')
parser.add_argument('name', type=str, help='name of the window')
parser.add_argument('--color-idx', type=int, help='manually change the color mapping for an index')
parser.add_argument('--color-name', type=int, help='manually change the color mapping for a name')
parser.add_argument('--clear-idx', action='store_true')
parser.add_argument('--clear-name', action='store_true')
parser.add_argument('--clear', action='store_true')
args = parser.parse_args()

state = {}
changed = True
try:
    with open(saved_state, "rb") as f:
        _state = pickle.load(f)
        if type(_state) is dict:
            state = _state
            changed = False
except Exception:
    pass

if args.clear:
    state = {}
    changed = True

if len(args.name) > 100:
    error("invalid name")
if args.idx < 0 or args.idx >= 1024:
    error("invalid idx")

if args.clear_idx:
    try:
        del state[args.idx]
    except Exception:
        pass
    changed = True

if args.clear_name:
    try:
        del state[args.name]
    except Exception:
        pass
    changed = True

if not (args.color_idx is None):
    if args.color_idx < 0 or args.color_idx >= 256:
        error("invalid color code")
        sys.exit(0)
    state[args.idx] = args.color_idx
    changed = True

if not (args.color_name is None):
    if args.color_name < 0 or args.color_name >= 256:
        error("invalid color code")
        sys.exit(0)
    state[args.name] = args.color_name
    changed = True

if changed:
    warn("wrote to the state")
    try:
        with open(saved_state, "wb") as f:
            pickle.dump(state, f)
    except Exception:
        warn("failed to dump file")
    sys.exit(0)

c = state.get(args.idx, None)
if c is None:
    c = state.get(args.name, None)
if c is None:
    h = hashlib.sha1(args.name.encode('utf-8')).digest()
    if sys.version_info.major == 3:
        hn = int.from_bytes(h, byteorder='big')
    else:
        hn = 0
        for b in bytearray(h):
            hn = hn * 256 + int(b)
    c = colors[hn % len(colors)]

print("colour{}".format(c))

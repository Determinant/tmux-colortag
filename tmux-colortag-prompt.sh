#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
case "$1" in
    prompt)
        tmux command-prompt -p '[ColorTag]:' "run-shell 'idx=#I name=#W $CURRENT_DIR/tmux-colortag-prompt.sh %1'"
        ;;
    color-idx)
        "$CURRENT_DIR/name2color.py" "$idx" "$name" --color-idx "$2" || echo "ColorTag: invalid argument"
        ;;
    color-name)
        "$CURRENT_DIR/name2color.py" "$idx" "$name" --color-name "$2" || echo "ColorTag: invalid argument"
        ;;
    clear-idx)
        "$CURRENT_DIR/name2color.py" "$idx" "$name" --clear-idx
        ;;
    clear-name)
        "$CURRENT_DIR/name2color.py" "$idx" "$name" --clear-name
        ;;
    clear-all)
        "$CURRENT_DIR/name2color.py" "$idx" "$name" --clear
        ;;
    *) echo "ColorTag: invalid command"; exit 0;;
esac

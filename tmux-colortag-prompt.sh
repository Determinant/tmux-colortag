#!/usr/bin/env bash

run_python() {
    err=$("$CURRENT_DIR/name2color.py" "$session" "$idx" "$name" "$@") || tmux display "ColorTag: invalid argument"
    if [[ "$err" != "" ]]; then
        tmux display "$err"
    fi
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
case "$1" in
    prompt)
        tmux command-prompt -p '[ColorTag]:' "run-shell 'idx=#I name=#W session=#S $CURRENT_DIR/tmux-colortag-prompt.sh %1'"
        ;;
    color-idx)
        run_python --color-idx "$2"
        ;;
    color-name)
        run_python --color-name "$2"
        ;;
    clear-idx)
        run_python --clear-idx
        ;;
    clear-name)
        run_python --clear-name
        ;;
    clear-all)
        run_python --clear
        ;;
    '') ;;
    help)
        echo "# Tmux ColorTag"
        echo "# Ted Yin <tederminant@gmail.com>"
        echo "Note: color overriding order: color-idx > color-name > auto"
        echo "color-idx <0-255>: manually set the color for the window index"
        echo "color-name <0-255>: manually set the color for the name"
        echo "clear-idx: clears the preivous color of the index"
        echo "clear-name: clears the preivous color of the name"
        echo "clear-all: use auto-coloring for all window tags"
        ;;
    *) tmux display "ColorTag: invalid command"; exit 0;;
esac

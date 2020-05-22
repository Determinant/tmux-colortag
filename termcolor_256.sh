#!/bin/bash
# http://askubuntu.com/questions/821157/print-a-256-color-test-pattern-in-the-terminal
echo "ColorTag: available color code"
echo
for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        printf "\n";
    fi
done
read -n 1 -s -r -p "[Press any key to exit]"

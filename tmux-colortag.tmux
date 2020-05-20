#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMUX_COLORTAG_SET_INTERVAL="${TMUX_COLORTAG_SET_INTERVAL:-yes}"

if [[ "$TMUX_COLORTAG_SET_INTERVAL" == yes ]]; then
    tmux set -g status on
    tmux set -g status-interval 2
fi

tmux set -g status-style bg=colour237
tmux set -g message-style fg=colour237,bg=colour248
tmux set -g message-command-style fg=colour237,bg=colour248
tmux set -g pane-active-border-style fg=colour240
tmux set -g pane-border-style fg=colour236,bg=colour235
tmux set -g pane-active-border-style bg=colour235
tmux setw -g window-status-style fg=colour237,bg=colour237,none
tmux setw -g window-status-activity-style bg=colour237,fg=colour248,none
tmux setw -g window-status-bell-style bg=colour237,fg=colour248,none
tmux setw -g window-status-separator ""

if [[ "$TMUX_COLORTAG_NOPOWERLINE" == yes ]]; then
    tmux set -g status-left "#{?client_prefix,#[fg=colour241]#[bg=colour248],#[fg=colour248]#[bg=colour241]} #S#{?client_prefix,#[fg=colour248],#[fg=colour241]} #[bg=colour237] "
    tmux set -g status-right "#[fg=colour239,bg=colour237] #[fg=colour246,bg=colour239] #(awk '{print \$1, \$2, \$3}' /proc/loadavg) #[fg=colour248,bg=colour239] #[fg=colour237,bg=colour248] #h "
    tmux setw -g window-status-format "#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)] #I|#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]#W #[fg=#(\"$CURRENT_DIR/name2color.py\" #W),bg=colour237] "
    tmux setw -g window-status-current-format "#[fg=colour255,bg=#(\"$CURRENT_DIR/name2color.py\" #W)] #I|#[fg=colour255,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]#W #[fg=#(\"$CURRENT_DIR/name2color.py\" #W),bg=colour237] "
else
    TMUX_ARROW_SYMBOL_L1="${TMUX_ARROW_SYMBOL_L1:-$(printf '\ue0b6')}"
    TMUX_ARROW_SYMBOL_L2="${TMUX_ARROW_SYMBOL_L2:-$(printf '\ue0b7')}"
    TMUX_ARROW_SYMBOL_R1="${TMUX_ARROW_SYMBOL_R1:-$(printf '\ue0b4')}"
    TMUX_ARROW_SYMBOL_R2="${TMUX_ARROW_SYMBOL_R2:-$(printf '\ue0b5')}"
    
    tmux set -g status-left "#{?client_prefix,#[fg=colour241]#[bg=colour248],#[fg=colour248]#[bg=colour241]} #S#{?client_prefix,#[fg=colour248],#[fg=colour241]}#[bg=colour237]$TMUX_ARROW_SYMBOL_R1 "
    tmux set -g status-right "#[fg=colour239,bg=colour237]$TMUX_ARROW_SYMBOL_L1#[fg=colour246,bg=colour239] #(awk '{print \$1, \$2, \$3}' /proc/loadavg) #[fg=colour248,bg=colour239]$TMUX_ARROW_SYMBOL_L1#[fg=colour237,bg=colour248] #h "
    tmux setw -g window-status-format "#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]$TMUX_ARROW_SYMBOL_R1#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)] #I$TMUX_ARROW_SYMBOL_R2#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]#W#[fg=#(\"$CURRENT_DIR/name2color.py\" #W),bg=colour237]$TMUX_ARROW_SYMBOL_R1 "
    tmux setw -g window-status-current-format "#[fg=colour237,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]$TMUX_ARROW_SYMBOL_R1#[fg=colour255,bg=#(\"$CURRENT_DIR/name2color.py\" #W)] #I$TMUX_ARROW_SYMBOL_R2#[fg=colour255,bg=#(\"$CURRENT_DIR/name2color.py\" #W)]#W#[fg=#(\"$CURRENT_DIR/name2color.py\" #W),bg=colour237]$TMUX_ARROW_SYMBOL_R1 "
fi

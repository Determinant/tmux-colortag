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

color0=colour237
color1=colour239
color2=colour255
color3=colour246
color4=colour248
color5=colour241

RECOVER_BG="#[bg=$color0]"
LEFTBAR_FORMAT="#{?client_prefix,#[fg=$color5]#[bg=$color4],#[fg=$color4]#[bg=$color5]} #S#{?client_prefix,#[fg=$color4],#[fg=$color5]}"
RIGHTBAR_DEFAULT="#[fg=$color3,bg=$color1]"
RIGHTBAR_DEFAULT0="#[fg=$color1,bg=$color0]"
RIGHTBAR_HOST="#[fg=$color0,bg=$color4]"
RIGHTBAR_HOST0="#[fg=$color4,bg=$color1]"
LOAD_DISP="#(awk '{print \$1, \$2, \$3}' /proc/loadavg)"
TAB_COLOR="#(\"$CURRENT_DIR/name2color.py\" #W)"
TAB_NORMAL_BEGIN="#[fg=$color0,bg=$TAB_COLOR]"
TAB_END="#[fg=$TAB_COLOR,bg=$color0]"
TAB_FOCUS_BEGIN_BG="#[bg=$TAB_COLOR]"
TAB_FOCUS_BEGIN_FG="#[fg=$color2]"
TAB_FOCUS_BEGIN="${TAB_FOCUS_BEGIN_BG}${TAB_FOCUS_BEGIN_FG}"

if [[ "$TMUX_COLORTAG_NOPOWERLINE" == yes ]]; then
    tmux set -g status-left  "${LEFTBAR_FORMAT} ${RECOVER_BG} "
    tmux set -g status-right "${RIGHTBAR_DEFAULT} ${LOAD_DISP} ${RIGHTBAR_HOST} #h "
    tmux setw -g window-status-format "${TAB_NORMAL_BEGIN} #I|#W ${TAB_END} "
    tmux setw -g window-status-current-format "${TAB_FOCUS_BEGIN} #I|#W ${TAB_END} "
else
    TMUX_ARROW_SYMBOL_L1="${TMUX_ARROW_SYMBOL_L1:-$(printf '\ue0b6')}"
    TMUX_ARROW_SYMBOL_L2="${TMUX_ARROW_SYMBOL_L2:-$(printf '\ue0b7')}"
    TMUX_ARROW_SYMBOL_R1="${TMUX_ARROW_SYMBOL_R1:-$(printf '\ue0b4')}"
    TMUX_ARROW_SYMBOL_R2="${TMUX_ARROW_SYMBOL_R2:-$(printf '\ue0b5')}"
    
    tmux set -g status-left "${LEFTBAR_FORMAT}${RECOVER_BG}${TMUX_ARROW_SYMBOL_R1} "
    tmux set -g status-right "$(printf %s \
        "${RIGHTBAR_DEFAULT0}$TMUX_ARROW_SYMBOL_L1" \
        "${RIGHTBAR_DEFAULT}${LOAD_DISP} " \
        "${RIGHTBAR_HOST0}${TMUX_ARROW_SYMBOL_L1}" \
        "${RIGHTBAR_HOST}#h ")"
    tmux setw -g window-status-format "$(printf %s \
        "${TAB_NORMAL_BEGIN}$TMUX_ARROW_SYMBOL_R1 " \
        "#I$TMUX_ARROW_SYMBOL_R2#W${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
    tmux setw -g window-status-current-format "$(printf %s \
        "${TAB_FOCUS_BEGIN_BG}$TMUX_ARROW_SYMBOL_R1 " \
        "${TAB_FOCUS_BEGIN_FG}#I$TMUX_ARROW_SYMBOL_R2#W${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
fi

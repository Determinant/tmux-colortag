#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMUX_COLORTAG_SET_INTERVAL="${TMUX_COLORTAG_SET_INTERVAL:-yes}"
TMUX_COLORTAG_TAG_ONLY="${TMUX_COLORTAG_TAG_ONLY:-no}"
TMUX_COLORTAG_USE_POWERLINE="${TMUX_COLORTAG_USE_POWERLINE:-no}"
TMUX_COLORTAG_KEY="${TMUX_COLORTAG_KEY:-C}"

if [[ "$TMUX_COLORTAG_SET_INTERVAL" == yes ]]; then
    tmux set -g status on
    tmux set -g status-interval 2
fi

color0=colour237
color1=colour239
color2=colour255
color3=colour246
color4=colour248
color5=colour241
color6=colour240
color7=colour236
color8=colour235

if [[ "$TMUX_COLORTAG_TAG_ONLY" != yes ]]; then
    tmux set -g message-style fg=$color0,bg=$color4
    tmux set -g message-command-style fg=$color0,bg=$color4
    tmux set -g pane-active-border-style fg=$color6
    tmux set -g pane-border-style fg=$color7,bg=$color8
    tmux set -g pane-active-border-style bg=$color8
fi

tmux set -g window-status-separator ""
tmux set -g status-style bg=$color0
tmux set -g window-status-style fg=$color0,bg=$color0,none
tmux set -g window-status-activity-style bg=$color0,fg=$color4,none
tmux set -g window-status-bell-style bg=$color0,fg=$color4,none

RECOVER_BG="#[bg=$color0]"
LEFTBAR_FORMAT="$(printf "%s" \
    "#{?client_prefix,#[fg=$color5]#[bg=$color4],#[fg=$color4]#[bg=$color5]} " \
    "#S#{?client_prefix,#[fg=$color4],#[fg=$color5]}")"
RIGHTBAR_DEFAULT="#[fg=$color3,bg=$color1]"
RIGHTBAR_DEFAULT0="#[fg=$color1,bg=$color0]"
RIGHTBAR_HOST="#[fg=$color0,bg=$color4]"
RIGHTBAR_HOST0="#[fg=$color4,bg=$color1]"
LOAD_DISP="#(awk '{print \$1, \$2, \$3}' /proc/loadavg)"
TAB_COLOR="#(\"$CURRENT_DIR/name2color.py\" #I #W)"
TAB_NORMAL_BEGIN="#[fg=$color0,bg=$TAB_COLOR]"
TAB_END="#[fg=$TAB_COLOR,bg=$color0]"
TAB_FOCUS_BEGIN_BG="#[bg=$TAB_COLOR]"
TAB_FOCUS_BEGIN_FG="#[fg=$color2]"
TAB_FOCUS_BEGIN="${TAB_FOCUS_BEGIN_BG}${TAB_FOCUS_BEGIN_FG}"

if [[ "$TMUX_COLORTAG_USE_POWERLINE" == no ]]; then
    TMUX_COLORTAG_IDX_SEP="${TMUX_COLORTAG_IDX_SEP:-|}"
    if [[ "$TMUX_COLORTAG_TAG_ONLY" != yes ]]; then
        tmux set -g status-left  "${LEFTBAR_FORMAT} ${RECOVER_BG} "
        tmux set -g status-right "${RIGHTBAR_DEFAULT} ${LOAD_DISP} ${RIGHTBAR_HOST} #h "
    fi
    tmux set -g window-status-format "${TAB_NORMAL_BEGIN} #I${TMUX_COLORTAG_IDX_SEP}#W ${TAB_END} "
    tmux set -g window-status-current-format "${TAB_FOCUS_BEGIN} #I${TMUX_COLORTAG_IDX_SEP}#W ${TAB_END} "
else
    TMUX_ARROW_SYMBOL_L1="${TMUX_ARROW_SYMBOL_L1:-$(printf '\ue0b6')}"
    TMUX_ARROW_SYMBOL_L2="${TMUX_ARROW_SYMBOL_L2:-$(printf '\ue0b7')}"
    TMUX_ARROW_SYMBOL_R1="${TMUX_ARROW_SYMBOL_R1:-$(printf '\ue0b4')}"
    TMUX_ARROW_SYMBOL_R2="${TMUX_ARROW_SYMBOL_R2:-$(printf '\ue0b5')}"
    TMUX_COLORTAG_IDX_SEP="${TMUX_COLORTAG_IDX_SEP:-$TMUX_ARROW_SYMBOL_R2}"
    
    if [[ "$TMUX_COLORTAG_TAG_ONLY" != yes ]]; then
        tmux set -g status-left "${LEFTBAR_FORMAT}${RECOVER_BG}${TMUX_ARROW_SYMBOL_R1} "
        tmux set -g status-right "$(printf %s \
            "${RIGHTBAR_DEFAULT0}$TMUX_ARROW_SYMBOL_L1" \
            "${RIGHTBAR_DEFAULT}${LOAD_DISP} " \
            "${RIGHTBAR_HOST0}${TMUX_ARROW_SYMBOL_L1}" \
            "${RIGHTBAR_HOST}#h ")"
    fi
    tmux set -g window-status-format "$(printf %s \
        "${TAB_NORMAL_BEGIN}$TMUX_ARROW_SYMBOL_R1 " \
        "#I${TMUX_COLORTAG_IDX_SEP}#W${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
    tmux set -g window-status-current-format "$(printf %s \
        "${TAB_FOCUS_BEGIN_BG}$TMUX_ARROW_SYMBOL_R1 " \
        "${TAB_FOCUS_BEGIN_FG}#I${TMUX_COLORTAG_IDX_SEP}#W${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
fi

tmux bind-key "$TMUX_COLORTAG_KEY" run-shell "'$CURRENT_DIR/tmux-colortag-prompt.sh' prompt"

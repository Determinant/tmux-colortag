#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMUX_COLORTAG_SET_INTERVAL="${TMUX_COLORTAG_SET_INTERVAL:-yes}"
TMUX_COLORTAG_TAG_ONLY="${TMUX_COLORTAG_TAG_ONLY:-no}"
TMUX_COLORTAG_USE_POWERLINE="${TMUX_COLORTAG_USE_POWERLINE:-no}"
TMUX_COLORTAG_KEY="${TMUX_COLORTAG_KEY:-C}"
TMUX_COLORTAG_TAG_BOLD="${TMUX_COLORTAG_TAG_BOLD:-no}"
TMUX_COLORTAG_TAG_FOCUS_UNDERLINE="${TMUX_COLORTAG_TAG_FOCUS_UNDERLINE:-yes}"

if [[ "$TMUX_COLORTAG_SET_INTERVAL" == yes ]]; then
    tmux set -g status on
    tmux set -g status-interval 2
fi

tab_text_attr=
if [[ "$TMUX_COLORTAG_TAG_BOLD" == yes ]]; then
    tab_text_attr+=",bold"
fi
focus_tab_text_attr="$tab_text_attr"
if [[ "$TMUX_COLORTAG_TAG_FOCUS_UNDERLINE" == yes ]]; then
    focus_tab_text_attr+=",underscore"
fi

bg0=${colortag_bg0:-colour235}
bg1=${colortag_bg1:-colour237}
white0=${colortag_white0:-colour255}
white1=${colortag_white1:-colour250}
lightgray=${colortag_lightgray:-colour248}
darkgray=${colortag_darkgray:-colour241}

TMUX_COLORTAG_TAG_FOCUS_TEXT_COLOR="${TMUX_COLORTAG_TAG_FOCUS_TEXT_COLOR:-$white0}"
TMUX_COLORTAG_TAG_TEXT_COLOR="${TMUX_COLORTAG_TAG_TEXT_COLOR:-$bg1}"

if [[ "$TMUX_COLORTAG_TAG_FOCUS_HIGHLIGHT" == yes ]]; then
    tab_focus_fg="$TMUX_COLORTAG_TAG_FOCUS_HIGHLIGHT"
fi

if [[ "$TMUX_COLORTAG_TAG_ONLY" != yes ]]; then
    tmux set -g message-style fg=$bg1,bg=$lightgray
    tmux set -g message-command-style fg=$bg1,bg=$lightgray
    tmux set -g pane-active-border-style fg=$white1,bg=$bg0
    tmux set -g pane-border-style fg=$bg1,bg=$bg0
    tmux set -g window-style bg=$bg0
    tmux set -g mode-style fg=$bg1,bg=$white1
fi

tmux set -g status-style bg=$bg1
tmux set -g window-status-separator ""
tmux set -g window-status-style fg=$bg1,bg=$bg1,none
tmux set -g window-status-activity-style bg=$bg1,fg=$lightgray,none
tmux set -g window-status-bell-style bg=$bg1,fg=$lightgray,none

RECOVER_BG="#[bg=$bg1]"
LEFTBAR_FORMAT="$(printf "%s" \
    "#{?client_prefix,#[fg=$darkgray]#[bg=$lightgray],#[fg=$lightgray]#[bg=$darkgray]} " \
    "#S#{?client_prefix,#[fg=$lightgray],#[fg=$darkgray]}")"
RIGHTBAR_DEFAULT="#[fg=$lightgray,bg=$darkgray]"
RIGHTBAR_DEFAULT0="#[fg=$darkgray,bg=$bg1]"
RIGHTBAR_HOST="#[fg=$bg1,bg=$lightgray]"
RIGHTBAR_HOST0="#[fg=$lightgray,bg=$darkgray]"
LOAD_DISP="#(awk '{print \$1, \$2, \$3}' /proc/loadavg)"
TAB_COLOR="#(\"$CURRENT_DIR/name2color.py\" #S #I #W)"
TAB_PREBEGIN="#[fg=$bg1,bg=${TAB_COLOR}]"
TAB_NORMAL_BEGIN="#[fg=${TMUX_COLORTAG_TAG_TEXT_COLOR}$tab_text_attr]"
TAB_END="#[fg=$TAB_COLOR,bg=$bg1,none]"
TAB_FOCUS_BEGIN_BG="#[bg=$TAB_COLOR]"
TAB_FOCUS_BEGIN_FG="#[fg=$TMUX_COLORTAG_TAG_FOCUS_TEXT_COLOR$focus_tab_text_attr]"
TAB_PREEND_FG="#[fg=${TMUX_COLORTAG_TAG_TEXT_COLOR},none]"
TAB_FOCUS_BEGIN="${TAB_FOCUS_BEGIN_BG}${TAB_FOCUS_BEGIN_FG}"

if [[ "$TMUX_COLORTAG_USE_POWERLINE" == no ]]; then
    TMUX_COLORTAG_IDX_SEP="${TMUX_COLORTAG_IDX_SEP:-|}"
    if [[ "$TMUX_COLORTAG_TAG_ONLY" != yes ]]; then
        tmux set -g status-left  "${LEFTBAR_FORMAT} ${RECOVER_BG} "
        tmux set -g status-right "${RIGHTBAR_DEFAULT} ${LOAD_DISP} ${RIGHTBAR_HOST} #h "
    fi
    tmux set -g window-status-format "${TAB_PREBEGIN} ${TAB_NORMAL_BEGIN}#I${TMUX_COLORTAG_IDX_SEP}#W ${TAB_END} "
    tmux set -g window-status-current-format "${TAB_PREBEGIN} ${TAB_FOCUS_BEGIN}#I${TMUX_COLORTAG_IDX_SEP}#W${TAB_PREEND_FG} ${TAB_END} "
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
        "${TAB_PREBEGIN}$TMUX_ARROW_SYMBOL_R1 ${TAB_NORMAL_BEGIN}" \
        "#I${TMUX_COLORTAG_IDX_SEP}#W${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
    tmux set -g window-status-current-format "$(printf %s \
        "${TAB_FOCUS_BEGIN_BG}$TMUX_ARROW_SYMBOL_R1 " \
        "${TAB_FOCUS_BEGIN_FG}#I${TMUX_COLORTAG_IDX_SEP}#W${TAB_PREEND_FG}${TAB_END}$TMUX_ARROW_SYMBOL_R1 ")"
fi

tmux bind-key "$TMUX_COLORTAG_KEY" run-shell "'$CURRENT_DIR/tmux-colortag-prompt.sh' prompt"

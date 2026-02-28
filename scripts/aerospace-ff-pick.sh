#!/usr/bin/env bash
# Window picker for iTerm2 Hotkey Window.
# Runs once per invocation - configure iTerm2 profile command to this script.

export PATH="/opt/homebrew/bin:$PATH"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

selected=$("$SCRIPT_DIR/aerospace-ff-windows.sh" all | fzf \
  --ansi \
  --delimiter=$'\t' \
  --with-nth=2.. \
  --nth=2.. \
  --prompt='All > ' \
  --header='/: cycle filter | ctrl-s: toggle sort | tab/esc: exit' \
  --bind="/:transform:bash -c '
        if [[ \$FZF_PROMPT == \"All > \" ]]; then
            echo \"change-prompt(Workspace > )+reload($SCRIPT_DIR/aerospace-ff-windows.sh workspace)\";
        elif [[ \$FZF_PROMPT == \"Workspace > \" ]]; then
            echo \"change-prompt(Floating > )+reload($SCRIPT_DIR/aerospace-ff-windows.sh floating)\";
        else
            echo \"change-prompt(All > )+reload($SCRIPT_DIR/aerospace-ff-windows.sh all)\";
        fi'" \
  --bind='ctrl-s:toggle-sort' \
  --bind="|:reload:$SCRIPT_DIR/aerospace-ff-windows.sh all" \
  --bind="tab,esc:execute-silent(osascript -e 'tell application \"System Events\" to keystroke TAB using option down')" \
  --tiebreak=begin,index \
  --cycle --layout=reverse --border --height=100% \
  --marker="*")

if [[ -n "$selected" ]]; then
  wid=$(echo "$selected" | cut -f1)
  aerospace focus --window-id "$wid"
fi
# --bind="esc:reload:$SCRIPT_DIR/aerospace-ff-windows.sh all" \

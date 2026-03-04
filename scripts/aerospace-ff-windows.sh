#!/usr/bin/env bash
set -euo pipefail

# Usage: aerospace-ff-windows.sh [all|workspace|floating|iterm2]
# Outputs tab-separated, ANSI-colored, column-aligned lines for fzf.

mode="${1:-all}"
app_width=20
title_width=60

ellipsis=$'\xe2\x80\xa6'

truncate() {
  local str="$1" max="$2"
  local charlen=${#str}
  local bytelen=$(
    LC_ALL=C
    echo "${#str}"
  )
  local extra=$((bytelen - charlen))

  if ((charlen > max)); then
    local truncated="${str:0:$((max - 1))}"
    local tbytelen=$(
      LC_ALL=C
      echo "${#truncated}"
    )
    local textra=$((tbytelen - (max - 1)))
    printf '%-*s' "$((max + textra))" "${truncated}${ellipsis}"
  else
    printf '%-*s' "$((max + extra))" "$str"
  fi
}

case "$mode" in
workspace) scope="--workspace focused" ;;
*) scope="--all" ;;
esac

filter_app=""
if [[ "$mode" == "iterm2" ]]; then
  filter_app="iTerm2"
fi

# shellcheck disable=SC2086
aerospace list-windows $scope \
  --format '%{window-id}|||%{app-name}|||%{window-title}|||%{workspace}|||%{window-layout}' |
  while IFS= read -r line; do
    wid="${line%%|||*}"
    line="${line#*|||}"
    app="${line%%|||*}"
    line="${line#*|||}"
    title="${line%%|||*}"
    line="${line#*|||}"
    ws="${line%%|||*}"
    layout="${line#*|||}"
    if [[ "$mode" == "floating" && "$layout" != "floating" ]]; then
      continue
    fi
    if [[ -n "$filter_app" && "$app" != "$filter_app" ]]; then
      continue
    fi

    if [[ "$layout" == "floating" ]]; then
      indicator=$'\033[33m[~]\033[0m'
    else
      indicator="   "
    fi

    app_col=$(truncate "$app" "$app_width")
    title_col=$(truncate "$title" "$title_width")

    printf '%s\t%s\t\033[36m%s\033[0m\t%s\t\033[2m%s\033[0m\n' \
      "$wid" "$indicator" "$app_col" "$title_col" "$ws"
  done

#!/usr/bin/env bash
set -euo pipefail

# Toggle between tiling and centered-floating for the focused window.
# Uses Moom's custom action for centering instead of manual AppleScript math.
#
# Uses AeroSpace's error behavior for detection:
#   - 'layout floating' fails if already floating → falls through to 'layout tiling'
#   - 'layout floating' succeeds if tiling → centers via Moom

center_window() {
  osascript -e 'tell application "Moom" to run "Rich - Med Center"'
}

aerospace layout floating && center_window || aerospace layout tiling

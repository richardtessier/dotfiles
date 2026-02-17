#!/usr/bin/env bash
set -euo pipefail

# Toggle between tiling and centered-floating for the focused window.
#
# Uses AeroSpace's error behavior for detection:
#   - 'layout floating' fails if already floating → falls through to 'layout tiling'
#   - 'layout floating' succeeds if tiling → centers the window via AppleScript
#
# Centering uses NSScreen for accurate multi-monitor support (no hardcoded
# monitor names, no temp files, no external dependencies beyond osascript).

center_window() {
  osascript <<'APPLESCRIPT'
use framework "AppKit"
use scripting additions

tell application "System Events"
    set frontProc to first application process whose frontmost is true
    set {wx, wy} to position of first window of frontProc
end tell

-- NSRect 'as list' becomes nested: {{origin.x, origin.y}, {width, height}}
set allScreens to current application's NSScreen's screens()
set primaryScreen to allScreens's objectAtIndex:0
set primaryFrame to primaryScreen's frame() as list
set pH to item 2 of item 2 of primaryFrame

-- Convert window Y from System Events (top-left origin) to NSScreen (bottom-left origin)
set nsWinY to pH - wy

-- Find which screen contains the window's top-left corner
set targetVF to missing value
repeat with s in allScreens
    set vf to s's visibleFrame() as list
    set ox to item 1 of item 1 of vf
    set oy to item 2 of item 1 of vf
    set ow to item 1 of item 2 of vf
    set oh to item 2 of item 2 of vf
    if wx is greater than or equal to ox and wx is less than (ox + ow) and ¬
       nsWinY is greater than or equal to oy and nsWinY is less than or equal to (oy + oh) then
        set targetVF to vf
        exit repeat
    end if
end repeat

-- Fall back to primary screen if detection fails
if targetVF is missing value then
    set targetVF to primaryScreen's visibleFrame() as list
end if

set fx to item 1 of item 1 of targetVF
set fy to item 2 of item 1 of targetVF
set fw to item 1 of item 2 of targetVF
set fh to item 2 of item 2 of targetVF

-- 60% of visible screen area, centered
set nw to round (fw * 0.6)
set nh to round (fh * 0.75)
set nx to round (fx + (fw - nw) / 2)
-- Convert Y back to System Events coordinates (top-left origin)
set ny to round (pH - fy - (fh + nh) / 2)

tell application "System Events"
    tell frontProc
        set position of first window to {nx, ny}
        set size of first window to {nw, nh}
    end tell
end tell
APPLESCRIPT
}

aerospace layout floating && center_window || aerospace layout tiling

#!/usr/bin/env bash
set -euo pipefail

# Nuclear "show everything" -- tile all floating windows, flatten the tree,
# and set horizontal tiles for a clean side-by-side overview.

# 1. Tile all floating windows (bring into tree)
aerospace list-windows --workspace focused --format '%{window-id} %{window-layout}' |
  while read -r wid layout; do
    if [ "$layout" = "floating" ]; then
      aerospace layout --window-id "$wid" tiling
    fi
  done

# 2. Flatten the tree (remove nesting)
aerospace flatten-workspace-tree

# 3. Set horizontal tiles (side-by-side overview)
aerospace layout tiles horizontal

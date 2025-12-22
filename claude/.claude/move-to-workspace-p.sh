#!/bin/bash

# Move Chrome Canary automation window to workspace P
# This script finds the Chrome Canary window and moves it to workspace P
window_id=$(aerospace list-windows --monitor all --app-bundle-id com.google.Chrome.canary | grep Automaton | awk -F' *\\| *' '{print $1}')
aerospace move-node-to-workspace --window-id ${window_id} P >/dev/null 2>&1
exit 0

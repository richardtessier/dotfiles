#!/bin/bash
# Toggle layout across all workspaces in AeroSpace

# Save current workspace
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Get all workspaces that currently exist
WORKSPACES=$(aerospace list-workspaces --all)

# Loop through each workspace and apply the layout toggle
for workspace in $WORKSPACES; do
    aerospace workspace "$workspace"
    aerospace layout h_accordion h_tiles
done

# Return to original workspace
aerospace workspace "$CURRENT_WORKSPACE"

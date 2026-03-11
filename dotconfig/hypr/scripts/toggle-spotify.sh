#!/bin/bash

# Find Spotify client information
spotify_info=$(hyprctl clients -j | jq -c '.[] | select(.class == "spotify" or .class == "Spotify")' | head -n 1)

if [[ -z "$spotify_info" ]]; then
    # Spotify not found, launch it
    spotify &
    exit 0
fi

# Extract address and workspace name
address=$(echo "$spotify_info" | jq -r '.address')
workspace=$(echo "$spotify_info" | jq -r '.workspace.name')

if [[ "$workspace" == special* ]]; then
    # Show: move from special workspace to current
    current_workspace=$(hyprctl activeworkspace -j | jq -r '.name')
    hyprctl dispatch movetoworkspacesilent "$current_workspace,address:$address"
else
    # Hide: move to special workspace
    hyprctl dispatch movetoworkspacesilent "special:spotify,address:$address"
fi
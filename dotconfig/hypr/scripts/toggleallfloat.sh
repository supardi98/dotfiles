#!/usr/bin/env bash

# Project Ricing: Modern Toggle All Float (No Notifications)

# Get current workspace ID
active_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Get all window addresses in the active workspace
mapfile -t window_addresses < <(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $active_workspace) | .address")

if [ ${#window_addresses[@]} -eq 0 ]; then
    exit 0
fi

# Iterate and toggle each window
for addr in "${window_addresses[@]}"; do
    hyprctl dispatch togglefloating "address:$addr"
done

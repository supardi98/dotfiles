#!/usr/bin/env bash
# Project Ricing Waybar Launch Script
# Wrapper for standalone compatibility

# Path to the main waybar launch script
LAUNCH_SCRIPT="$HOME/.config/hypr/scripts/launch-waybar.sh"

if [ -f "$LAUNCH_SCRIPT" ]; then
    bash "$LAUNCH_SCRIPT"
else
    # Fallback if the script isn't found
    killall waybar || true
    sleep 0.5
    waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" &
fi

#!/usr/bin/env bash
# Project Ricing Waybar Launch Script

# Kill existing waybar instances
killall waybar || true

# Wait a bit
sleep 0.5

# Start waybar with project config
waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" &

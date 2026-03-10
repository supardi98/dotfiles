#!/usr/bin/env bash
# Project Ricing Waybar Launch Script

# Kill existing waybar instances
killall waybar || true

# Wait a bit
sleep 0.5

# Start waybar with project config
project_dir="/home/supardi/Projects/ricing"
waybar -c "$project_dir/config.jsonc" -s "$project_dir/style.css" &

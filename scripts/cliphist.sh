#!/usr/bin/env bash
# Clipboard Manager Script for Ricing Project
# Using Glassy macOS theme

# Project directory
project_dir="$HOME/Projects/ricing"
config_file="$project_dir/conf/rofi/cliphist.rasi"

case $1 in
    d)
        cliphist list | rofi -dmenu -replace -config "$config_file" -p "󰅇 Delete" | cliphist delete
    ;;
    w)    
        cliphist wipe
    ;;
    *)
        cliphist list | rofi -dmenu -replace -config "$config_file" -p "󰅇 Clipboard" | cliphist decode | wl-copy
    ;;
esac

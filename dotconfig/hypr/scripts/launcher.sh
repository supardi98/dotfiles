#!/usr/bin/env bash

# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
config_dir="$HOME/.config/rofi"
config_file="$config_dir/glassy.rasi"

pkill rofi || rofi -show drun -replace -config "$config_file" -i  

#!/usr/bin/env bash
# Reload Hyprland and Waybar

# 1. Reload Hyprland
hyprctl reload

# 2. Reload Waybar (via existing launch-waybar script)
# Pastikan script ini dipanggil via absolute path atau menggunakan variabel yang tepat
$HOME/.config/hypr/scripts/launch-waybar.sh

# 3. Kirim notifikasi
notify-send "Ricing Pro" "Hyprland & Waybar Reloaded 🚀"

#!/usr/bin/env bash
# ✨ Random Wallpaper Selector (Clean Version)

WALLPAPER_DIR="$HOME/.config/wallpapers"

# Ambil satu gambar secara acak
selected_path=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.jpeg" \) | shuf -n 1)

if [ -n "$selected_path" ]; then
    # Panggil skrip utama untuk mengganti wallpaper, update warna, dan simpan cache
    ~/.config/hypr/scripts/wallpaper.sh "$selected_path"
    notify-send "Wallpaper" "Randomly changed to $(basename "$selected_path")"
fi

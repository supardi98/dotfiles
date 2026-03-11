#!/usr/bin/env bash
# ✨ Random Wallpaper Selector using awww

WALLPAPER_DIR="$HOME/.config/ml4w/wallpapers"
CACHE_FILE="$HOME/.cache/hyprland-dotfiles/current_wallpaper"

# Ambil satu gambar secara acak dari folder wallpaper
selected_path=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.jpeg" \) | shuf -n 1)

if [ -n "$selected_path" ]; then
    # 1. Terapkan wallpaper dengan awww
    if ! pgrep -x "awww-daemon" > /dev/null; then
        awww-daemon &
        sleep 1
    fi
    awww img "$selected_path" --transition-type any --transition-step 90 --transition-duration 2

    # 2. Jalankan skrip pemroses warna (Matugen, dsb)
    ~/.config/hypr/scripts/wallpaper.sh "$selected_path"
    
    notify-send "Wallpaper" "Randomly changed to $(basename "$selected_path")"
fi

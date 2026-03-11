#!/usr/bin/env bash
# ✨ Random Wallpaper Selector (Stable & Simple)

# Tentukan direktori wallpaper
WALLPAPER_DIR="$HOME/.config/wallpapers"

# Pastikan direktori ada
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR not found."
    exit 1
fi

# Cari semua gambar dengan cara yang lebih simpel
# Mengambil satu secara acak
selected_path=$(ls "$WALLPAPER_DIR"/*.{jpg,png,gif,jpeg} 2>/dev/null | shuf -n 1)

if [ -n "$selected_path" ]; then
    echo "Selected: $selected_path"
    # Panggil skrip utama untuk mengganti wallpaper
    ~/.config/hypr/scripts/wallpaper.sh "$selected_path"
    notify-send "Wallpaper" "Randomly changed to $(basename "$selected_path")"
else
    echo "No wallpapers found in $WALLPAPER_DIR"
    # Fallback ke default jika tidak ada
    ~/.config/hypr/scripts/wallpaper.sh "$WALLPAPER_DIR/default.jpg"
fi

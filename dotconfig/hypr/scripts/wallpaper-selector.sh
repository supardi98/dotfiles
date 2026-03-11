#!/usr/bin/env bash
# ✨ Rofi Wallpaper Selector with Thumbnails & Color Sync (Matugen)

WALLPAPER_DIR="$HOME/.config/ml4w/wallpapers"
CACHE_FILE="$HOME/.cache/hyprland-dotfiles/current_wallpaper"

# Pastikan awww-daemon berjalan
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 1
fi

# Bangun daftar untuk Rofi
list_wallpapers() {
    for file in "$WALLPAPER_DIR"/*.{jpg,png,gif,jpeg}; do
        [ -e "$file" ] || continue
        echo -en "$(basename "$file")\0icon\x1f$file\n"
    done
}

# Pilih wallpaper dengan Rofi
selected_name=$(list_wallpapers | rofi -dmenu -i -theme ~/.config/rofi/wallpaper.rasi -p "󰸉 Select Wallpaper")

if [ -n "$selected_name" ]; then
    selected_path="$WALLPAPER_DIR/$selected_name"
    
    # 1. Terapkan wallpaper dengan awww
    awww img "$selected_path" --transition-type outer --transition-step 90 --transition-duration 2

    # 2. Jalankan skrip pemroses warna (Matugen, SwayNC, dsb)
    # Skrip ini akan memperbarui colors.conf dan border Hyprland
    ~/.config/hypr/scripts/wallpaper.sh "$selected_path"
    
    notify-send "Wallpaper" "Wallpaper and colors updated to $selected_name"
fi

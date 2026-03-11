#!/usr/bin/env bash
# ✨ Rofi Wallpaper Selector (Clean Version)

WALLPAPER_DIR="$HOME/.config/ml4w/wallpapers"

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
    
    # Jalankan skrip utama untuk ganti wallpaper, update warna, dan simpan cache
    ~/.config/hypr/scripts/wallpaper.sh "$selected_path"
    
    notify-send "Wallpaper" "Wallpaper changed to $selected_name"
fi

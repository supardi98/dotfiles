#!/usr/bin/env bash
# ✨ Restore last wallpaper and sync colors on login

project_cache_folder="$HOME/.cache/hyprland-dotfiles"
defaultwallpaper="$HOME/.config/wallpapers/default.jpg"
cachefile="$project_cache_folder/current_wallpaper"

# Pastikan awww-daemon berjalan
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 1
fi

# Ambil wallpaper terakhir dari cache
if [ -f "$cachefile" ]; then
    wallpaper=$(cat "$cachefile" | sed "s|~|$HOME|g")
    [ ! -f "$wallpaper" ] && wallpaper=$defaultwallpaper
else
    wallpaper=$defaultwallpaper
fi

# Terapkan wallpaper dan proses warna (Matugen, dsb)
echo ":: Restoring wallpaper and colors: $wallpaper"
~/.config/hypr/scripts/wallpaper.sh "$wallpaper"

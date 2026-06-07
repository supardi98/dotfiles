#!/usr/bin/env bash
# 🔄 SDDM Wallpaper Sync Hook
LOG_FILE="/tmp/sddm-sync.log"
echo "--- Sync attempt at $(date) ---" >> "$LOG_FILE"
echo "Argument 1: $1" >> "$LOG_FILE"

THEME_PATH="/usr/share/sddm/themes/sddm-astronaut-theme"
SDDM_CONF="$THEME_PATH/Themes/astronaut.conf"

# 1. Ambil path wallpaper dari argumen
NEW_WALL="$1"

# Handle tilde expansion if passed as string
if [[ "$NEW_WALL" == ~* ]]; then
    NEW_WALL="${NEW_WALL/#\~/$HOME}"
fi

# Jika tidak ada argumen, coba cari dari swww
if [ -z "$NEW_WALL" ] && command -v swww > /dev/null; then
    NEW_WALL=$(swww query | grep -oP '(?<=image: ).*')
fi

# Jika masih kosong, coba ambil dari cache Noctalia
if [ -z "$NEW_WALL" ]; then
    CACHE_FILE="$HOME/.cache/noctalia/wallpapers.json"
    if [ -f "$CACHE_FILE" ]; then
        echo "Reading from Noctalia cache..." >> "$LOG_FILE"
        # Ambil wallpaper untuk eDP-1 (atau monitor pertama)
        NEW_WALL=$(jq -r '.wallpapers["eDP-1"].dark // (.wallpapers | to_entries[0].value.dark)' "$CACHE_FILE")
    fi
fi

echo "Detected wallpaper: $NEW_WALL" >> "$LOG_FILE"

if [ -f "$NEW_WALL" ]; then
    echo "Syncing $NEW_WALL to SDDM..." >> "$LOG_FILE"
    
    # 2. Salin wallpaper ke folder SDDM (sebagai 'current_wallpaper.png')
    # Kita gunakan sudo tanpa password jika user sudah diatur, atau asumsi script ini dijalankan dengan hak yang cukup
    sudo cp "$NEW_WALL" "$THEME_PATH/Backgrounds/current_wallpaper.png"
    
    # 3. Update file .conf tema agar menunjuk ke wallpaper baru
    sudo sed -i "s|^Background=.*|Background=\"Backgrounds/current_wallpaper.png\"|" "$SDDM_CONF"
    
    notify-send -u low "System" "SDDM Wallpaper synchronized! 🖼️"
else
    echo "Wallpaper file not found: $NEW_WALL"
fi

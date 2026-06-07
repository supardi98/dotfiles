#!/usr/bin/env bash
# 🔄 SDDM Wallpaper Sync Hook

THEME_PATH="/usr/share/sddm/themes/sddm-astronaut-theme"
SDDM_CONF="$THEME_PATH/Themes/astronaut.conf"

# 1. Ambil path wallpaper dari argumen (dikirim oleh Waypaper)
NEW_WALL="$1"

if [ -f "$NEW_WALL" ]; then
    echo "Syncing $NEW_WALL to SDDM..."
    
    # 2. Salin wallpaper ke folder SDDM (sebagai 'current_wallpaper.png')
    # Kita gunakan sudo tanpa password jika user sudah diatur, atau asumsi script ini dijalankan dengan hak yang cukup
    sudo cp "$NEW_WALL" "$THEME_PATH/Backgrounds/current_wallpaper.png"
    
    # 3. Update file .conf tema agar menunjuk ke wallpaper baru
    sudo sed -i "s|^Background=.*|Background=\"Backgrounds/current_wallpaper.png\"|" "$SDDM_CONF"
    
    notify-send -u low "System" "SDDM Wallpaper synchronized! 🖼️"
else
    echo "Wallpaper file not found: $NEW_WALL"
fi

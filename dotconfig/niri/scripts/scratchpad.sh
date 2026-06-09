#!/usr/bin/env bash
# 🎮 Niri Scratchpad Toggle (Quake Style)

APP_ID="quake"

# Cek apakah jendela dengan app_id "quake" sedang fokus
if niri msg -j windows | jq -e ".[] | select(.app_id == \"$APP_ID\" and .is_focused == true)" > /dev/null; then
    # Jika sedang fokus, tutup jendela tersebut (hide)
    niri msg action close-window
else
    # Jika tidak ada atau tidak fokus, pastikan yang lama dimatikan lalu buka baru
    pkill -f "kitty --class $APP_ID" 2>/dev/null
    kitty --class "$APP_ID" &
fi

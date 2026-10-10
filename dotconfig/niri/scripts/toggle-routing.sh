#!/usr/bin/env bash
# 🔄 Toggle Smart Window Auto-Routing for Niri
# Hotkey: Super + Shift + A

CONFIG_FILE="$HOME/.config/niri/config.kdl"
INCLUDE_LINE='include "auto-routing.kdl"'
COMMENTED_LINE='// include "auto-routing.kdl"'

if [ ! -f "$CONFIG_FILE" ]; then
    notify-send -u critical "Auto-Routing" "Niri config file not found!"
    exit 1
fi

# Cek apakah saat ini aktif atau nonaktif
if grep -q "^include \"auto-routing.kdl\"" "$CONFIG_FILE"; then
    # Sedang aktif -> Nonaktifkan
    sed -i --follow-symlinks 's|^include "auto-routing.kdl"|// include "auto-routing.kdl"|' "$CONFIG_FILE"
    niri msg action load-config-file
    notify-send -u low -i preferences-system-windows -t 2500 "Auto-Routing: OFF" "Aplikasi akan terbuka di workspace aktif saat ini."
elif grep -q "^// include \"auto-routing.kdl\"" "$CONFIG_FILE"; then
    # Sedang nonaktif -> Aktifkan
    sed -i --follow-symlinks 's|^// include "auto-routing.kdl"|include "auto-routing.kdl"|' "$CONFIG_FILE"
    niri msg action load-config-file
    notify-send -u normal -i preferences-system-windows -t 2500 "Auto-Routing: ON" "WS1: Dev | WS2: Web | WS3: Chat/Music | WS4: Files"
else
    # Belum pernah ditambahkan baris include -> Tambahkan dan aktifkan
    echo "" >> "$CONFIG_FILE"
    echo "$INCLUDE_LINE" >> "$CONFIG_FILE"
    niri msg action load-config-file
    notify-send -u normal -i preferences-system-windows -t 2500 "Auto-Routing: ON" "WS1: Dev | WS2: Web | WS3: Chat/Music | WS4: Files"
fi

#!/usr/bin/env bash
# 🎨 Niri Color Sync Script (Lightweight)
# Only updates border color, no shell restart to avoid loops.

if command -v jq >/dev/null 2>&1; then
    SETTINGS_FILE="$HOME/.config/noctalia/settings.json"
    COLORS_FILE="$HOME/.config/noctalia/colors.json"
    DOT_CONFIG_FILE="/home/supardi/Projects/ricing/dotconfig/niri/config.kdl"
    
    # Ambil warna primer
    PRIMARY_COLOR=$(jq -r '.colorSchemes.Noctalia.mPrimary // empty' "$SETTINGS_FILE" 2>/dev/null)
    if [ -z "$PRIMARY_COLOR" ] && [ -f "$COLORS_FILE" ]; then
        PRIMARY_COLOR=$(jq -r '.mPrimary' "$COLORS_FILE")
    fi

    if [ ! -z "$PRIMARY_COLOR" ] && [[ "$PRIMARY_COLOR" =~ ^# ]]; then
        # Update file asli
        if [ -f "$DOT_CONFIG_FILE" ]; then
            sed -i "s/active-color \".*\" \/\/ Updated via reload.sh/active-color \"$PRIMARY_COLOR\" \/\/ Updated via reload.sh/" "$DOT_CONFIG_FILE"
            # Beritahu Niri untuk refresh (Ini aman, tidak bikin loop ke Noctalia)
            niri msg action load-config-file
        fi
    fi
fi

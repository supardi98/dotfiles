#!/usr/bin/env bash
# 🖥️ Show Desktop Toggle (Niri)
# Jumps to an empty clean workspace (e.g. workspace 9 or empty) to show desktop/wallpaper,
# and toggles back to previous workspace when triggered again.

PREV_WS_FILE="/tmp/niri_show_desktop_prev.txt"
FOCUSED_WS=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused) | .idx')

if [ -f "$PREV_WS_FILE" ]; then
    PREV_WS=$(cat "$PREV_WS_FILE")
    rm -f "$PREV_WS_FILE"
    if [ -n "$PREV_WS" ]; then
        niri msg action focus-workspace "$PREV_WS"
        exit 0
    fi
fi

# Simpan workspace saat ini dan pindah ke workspace kosong terbawah (9)
echo "$FOCUSED_WS" > "$PREV_WS_FILE"
niri msg action focus-workspace 9

#!/usr/bin/env bash
# 🖥️ Show Desktop Toggle (Niri)
# Jumps to a clean empty workspace (Workspace 5) to show desktop/wallpaper,
# and returns to the previous working workspace when triggered again.

PREV_WS_FILE="/tmp/niri_show_desktop_prev.txt"
FOCUSED_WS=$(niri msg -j workspaces 2>/dev/null | jq -r '.[] | select(.is_focused) | .idx')

if [ "$FOCUSED_WS" = "5" ] && [ -f "$PREV_WS_FILE" ]; then
    # Sedang di workspace 5 -> Balik ke workspace kerja sebelumnya
    PREV_WS=$(cat "$PREV_WS_FILE")
    rm -f "$PREV_WS_FILE"
    if [ -n "$PREV_WS" ] && [ "$PREV_WS" != "5" ]; then
        niri msg action focus-workspace "$PREV_WS"
        exit 0
    else
        niri msg action focus-workspace 1
        exit 0
    fi
fi

# Sedang di workspace kerja -> Simpan nomor workspace lalu lompat ke Workspace 5
echo "$FOCUSED_WS" > "$PREV_WS_FILE"
niri msg action focus-workspace 5

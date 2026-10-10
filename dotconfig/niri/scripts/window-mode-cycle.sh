#!/usr/bin/env bash
# 🔄 Cycle window modes: Default Tiling -> Full Width (Maximize Column) -> Fullscreen -> Default Tiling
set -euo pipefail

STATE_DIR="/tmp/niri-window-state"
mkdir -p "$STATE_DIR"

# Dapatkan info window aktif
WINDOW_INFO=$(niri msg --json focused-window 2>/dev/null || true)
if [[ -z "$WINDOW_INFO" || "$WINDOW_INFO" == "null" ]]; then
    exit 0
fi

WINDOW_ID=$(echo "$WINDOW_INFO" | jq -r '.id')
STATE_FILE="$STATE_DIR/win_${WINDOW_ID}.state"

CURRENT_STATE="default"
if [[ -f "$STATE_FILE" ]]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
fi

case "$CURRENT_STATE" in
    "default")
        # Step 1: Ke Full Width (maximize-column)
        niri msg action maximize-column
        echo "maximized" > "$STATE_FILE"
        ;;
    "maximized")
        # Step 2: Ke Fullscreen
        # Kembalikan maximize dulu agar state bersih, lalu fullscreen
        niri msg action maximize-column
        niri msg action fullscreen-window
        echo "fullscreen" > "$STATE_FILE"
        ;;
    "fullscreen"|*)
        # Step 3: Kembali ke Biasa (Default Tiling)
        niri msg action fullscreen-window
        echo "default" > "$STATE_FILE"
        ;;
esac

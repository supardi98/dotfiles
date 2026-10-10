#!/usr/bin/env bash
# 🎮 Niri Persistent Multi-Scratchpad Toggle (Quake Style, Lazygit, Notes, Calculator)
# Keeps windows alive in background instead of killing/closing them on toggle.

MODE="${1:-quake}"

case "$MODE" in
    lazygit|git)
        APP_ID="scratch-lazygit"
        TITLE="Lazygit"
        CMD="lazygit"
        ;;
    notes|note|nano)
        APP_ID="scratch-notes"
        TITLE="Quick Notes (Nano)"
        NOTES_DIR="$HOME/Notes"
        mkdir -p "$NOTES_DIR"
        CMD="nano -t -m -S -/ $NOTES_DIR/quicknotes.txt"
        ;;
    nvim|vim|learn)
        APP_ID="scratch-nvim"
        TITLE="Study Notes (Neovim)"
        NOTES_DIR="$HOME/Notes"
        mkdir -p "$NOTES_DIR"
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        CMD="nvim -u $SCRIPT_DIR/nvim-notes.lua $NOTES_DIR/learn-notes.md"
        ;;
    calc|calculator)
        APP_ID="scratch-calc"
        TITLE="Calculator (Qalculate)"
        CMD="qalc"
        ;;
    quake|*)
        APP_ID="quake"
        TITLE="Quake Terminal"
        CMD=""
        ;;
esac

# Ambil informasi jendela jika sudah berjalan
WIN_DATA=$(niri msg -j windows 2>/dev/null | jq -r ".[] | select(.app_id == \"$APP_ID\") | {id, is_focused}")
WIN_ID=$(echo "$WIN_DATA" | jq -r '.id // empty')
IS_FOCUSED=$(echo "$WIN_DATA" | jq -r '.is_focused // false')

# Fungsi untuk menyembunyikan jendela ke workspace background tanpa mematikan proses
hide_to_scratchpad() {
    local win_id="$1"
    if niri msg -j workspaces 2>/dev/null | jq -e '.[] | select(.name == "scratchpad")' >/dev/null 2>&1; then
        niri msg action move-window-to-workspace "scratchpad" --window-id "$win_id" --focus false
    else
        niri msg action move-window-to-workspace 99 --window-id "$win_id" --focus false
        local ws_id=$(niri msg -j windows 2>/dev/null | jq -r ".[] | select(.id == $win_id) | .workspace_id // empty")
        if [ -n "$ws_id" ]; then
            local ws_idx=$(niri msg -j workspaces 2>/dev/null | jq -r ".[] | select(.id == $ws_id) | .idx // empty")
            if [ -n "$ws_idx" ]; then
                niri msg action set-workspace-name "scratchpad" --workspace "$ws_idx"
            fi
        fi
    fi
}

if [ -n "$WIN_ID" ]; then
    if [ "$IS_FOCUSED" == "true" ]; then
        # Jika sedang aktif & fokus, sembunyikan ke background scratchpad
        hide_to_scratchpad "$WIN_ID"
    else
        # Jika ada di background (atau workspace lain), bawa ke workspace aktif saat ini dan fokus
        CUR_WS=$(niri msg -j workspaces 2>/dev/null | jq -r '.[] | select(.is_focused == true) | .idx // 1')
        niri msg action move-window-to-workspace "$CUR_WS" --window-id "$WIN_ID"
        niri msg action focus-window --id "$WIN_ID"
    fi
else
    # Jika belum ada jendela aktif, spawn instance baru
    if [ -n "$CMD" ]; then
        setsid -f kitty --class "$APP_ID" --title "$TITLE" -e sh -c "$CMD" >/dev/null 2>&1
    else
        setsid -f kitty --class "$APP_ID" --title "$TITLE" >/dev/null 2>&1
    fi
fi

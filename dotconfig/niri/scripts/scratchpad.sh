#!/usr/bin/env bash
# 🎮 Niri Multi-Scratchpad Toggle (Quake Style, Lazygit, Notes, Calculator)

MODE="${1:-quake}"

case "$MODE" in
    lazygit|git)
        APP_ID="scratch-lazygit"
        CMD="lazygit"
        ;;
    notes|note)
        APP_ID="scratch-notes"
        NOTES_DIR="$HOME/Notes"
        mkdir -p "$NOTES_DIR"
        CMD="nvim $NOTES_DIR/scratchpad.md"
        ;;
    calc|calculator)
        APP_ID="scratch-calc"
        CMD="qalc"
        ;;
    quake|*)
        APP_ID="quake"
        CMD=""
        ;;
esac

# Cek apakah jendela dengan app_id sedang fokus
if niri msg -j windows | jq -e ".[] | select(.app_id == \"$APP_ID\" and .is_focused == true)" > /dev/null 2>&1; then
    # Jika sedang fokus, tutup jendela tersebut (hide)
    niri msg action close-window
else
    # Jika jendela sudah ada di workspace lain/unfocused, tutup instance lama agar toggle bersih
    pkill -f "kitty --class $APP_ID" 2>/dev/null
    if [ -n "$CMD" ]; then
        setsid -f kitty --class "$APP_ID" -e sh -c "$CMD" >/dev/null 2>&1
    else
        setsid -f kitty --class "$APP_ID" >/dev/null 2>&1
    fi
fi

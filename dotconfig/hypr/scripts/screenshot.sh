#!/usr/bin/env bash
# 📸 Ricing Pro - Simplified Screenshot Tool

# Load Central Configuration
[ -f ~/.config/hypr/settings/ricing.conf ] && source ~/.config/hypr/settings/ricing.conf

# Notifications
source "$HOME/.config/hypr/scripts/notification-handler.sh"
APP_NAME="Screen Capture"
NOTIFICATION_ICON="camera-photo-symbolic"

# Configs
SAVE_DIR="${SCREENSHOT_FOLDER:-$HOME/Screenshots}"
EDITOR_CMD="${SCREENSHOT_EDITOR:-swappy}"
mkdir -p "$SAVE_DIR"

# Set Editor for grimblast
if [[ "$EDITOR_CMD" == "swappy" ]]; then
    export GRIMBLAST_EDITOR="swappy -f"
else
    export GRIMBLAST_EDITOR="$EDITOR_CMD"
fi

# Function to get filename
get_name() {
    echo "$SAVE_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"
}

# --- Actions ---

take_all() {
    grimblast --notify copysave screen "$(get_name)"
}

take_area() {
    grimblast --notify copysave area "$(get_name)"
}

take_window() {
    grimblast --notify copysave active "$(get_name)"
}

take_edit() {
    grimblast --notify edit area
}

take_delayed() {
    notify-send "Screenshot" "Mengambil gambar dalam 5 detik..." -t 2000
    sleep 5
    grimblast --notify copysave screen "$(get_name)"
}

# --- Command Line Flags (for Keybindings) ---
case "$1" in
    --instant)          take_all; exit 0 ;;
    --instant-area)     take_area; exit 0 ;;
    --copy-window)      take_window; exit 0 ;;
    --edit)             take_edit; exit 0 ;;
    --delayed)          take_delayed; exit 0 ;;
esac

# --- Interactive Menu (Rofi) ---
options="📸 Full Screen (Save & Copy)\n✂️ Area Selection (Save & Copy)\n🪟 Active Window (Save & Copy)\n🎨 Capture & Edit\n🕒 Delayed (5s)"

choice=$(echo -e "$options" | rofi -dmenu -i -config "$HOME/.config/rofi/glassy-list.rasi" -p "📸 Screenshot")

case "$choice" in
    *Full*)    take_all ;;
    *Area*)    take_area ;;
    *Window*)  take_window ;;
    *Edit*)    take_edit ;;
    *Delayed*) take_delayed ;;
esac

exit 0

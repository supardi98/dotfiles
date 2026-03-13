#!/usr/bin/env bash
# ⚙️ Ricing Pro - Configuration Manager

# Configuration Paths
CONFIG_FILE="$HOME/.config/hypr/settings/ricing.conf"
ROFI_CONFIG="$HOME/.config/rofi/glassy-list.rasi"

if [ ! -f "$CONFIG_FILE" ]; then
    notify-send "Error" "Config file not found: $CONFIG_FILE"
    exit 1
fi

source "$CONFIG_FILE"

# Function to check installed apps and build list for Rofi
check_apps() {
    local apps=("$@")
    local list=""
    for app in "${apps[@]}"; do
        if command -v "$app" &> /dev/null; then
            list+="$app (Installed)\n"
        else
            list+="$app (Not Found)\n"
        fi
    done
    list+="➕ Other (Custom)\n"
    echo -e "$list"
}

# Function to update config
update_config() {
    local var_name="$1"
    local new_val="$2"
    sed -i "s|export $var_name=.*|export $var_name=\"$new_val\"|g" "$CONFIG_FILE"
    notify-send "⚙️ Ricing Pro" "$var_name diubah ke $new_val"
}

# Menu options
options="🖥️ Change Terminal\n🌐 Change Browser\n📂 Change File Manager\n📝 Change Editor\n🎨 Change Matugen Mode\n📸 Change Screenshot Folder\n💾 Save & Reload"

choice=$(echo -e "$options" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "⚙️ Configuration")

case "$choice" in
    *Terminal*)
        # ... (rest of terminal logic)
        apps=("kitty" "alacritty" "foot" "xterm" "st")
        selected=$(check_apps "${apps[@]}" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "🖥️ Select Terminal")
        [ -z "$selected" ] && exit 0
        if [[ "$selected" == *"Other"* ]]; then
            new_val=$(rofi -dmenu -config "$ROFI_CONFIG" -p "⌨️ Enter Terminal Name:")
        else
            new_val=$(echo "$selected" | awk '{print $1}')
        fi
        [ ! -z "$new_val" ] && update_config "TERMINAL" "$new_val"
        ;;
    *Browser*)
        # ... (rest of browser logic)
        apps=("firefox", "brave" "chromium" "google-chrome-stable" "librewolf")
        selected=$(check_apps "${apps[@]}" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "🌐 Select Browser")
        [ -z "$selected" ] && exit 0
        if [[ "$selected" == *"Other"* ]]; then
            new_val=$(rofi -dmenu -config "$ROFI_CONFIG" -p "⌨️ Enter Browser Name:")
        else
            new_val=$(echo "$selected" | awk '{print $1}')
        fi
        [ ! -z "$new_val" ] && update_config "BROWSER" "$new_val"
        ;;
    *File*)
        # ... (rest of file logic)
        apps=("nautilus" "thunar" "dolphin" "pcmanfm" "nemo")
        selected=$(check_apps "${apps[@]}" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "📂 Select File Manager")
        [ -z "$selected" ] && exit 0
        if [[ "$selected" == *"Other"* ]]; then
            new_val=$(rofi -dmenu -config "$ROFI_CONFIG" -p "⌨️ Enter File Manager Name:")
        else
            new_val=$(echo "$selected" | awk '{print $1}')
        fi
        [ ! -z "$new_val" ] && update_config "FILEMANAGER" "$new_val"
        ;;
    *Editor*)
        # ... (rest of editor logic)
        apps=("nvim" "vim" "nano" "code" "geany")
        selected=$(check_apps "${apps[@]}" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "📝 Select Editor")
        [ -z "$selected" ] && exit 0
        if [[ "$selected" == *"Other"* ]]; then
            new_val=$(rofi -dmenu -config "$ROFI_CONFIG" -p "⌨️ Enter Editor Name:")
        else
            new_val=$(echo "$selected" | awk '{print $1}')
        fi
        if [ ! -z "$new_val" ]; then
            update_config "EDITOR" "$new_val"
            sed -i "s|export VISUAL=.*|export VISUAL=\"$new_val\"|g" "$CONFIG_FILE"
        fi
        ;;
    *Matugen*)
        new_val=$(echo -e "scheme-tonal-spot\nscheme-expressive\nscheme-fruit-salad\nscheme-rainbow\nscheme-monochrome\nscheme-content\nscheme-fidelity\nscheme-neutral" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "🎨 Matugen Mode")
        [ ! -z "$new_val" ] && update_config "MATUGEN_MODE" "$new_val"
        ;;
    *Screenshot*)
        new_val=$(echo -e "$HOME/Screenshots\n$HOME/Pictures/Screenshots\n$HOME/Desktop" | rofi -dmenu -i -config "$ROFI_CONFIG" -p "📸 Screenshot Folder")
        [ ! -z "$new_val" ] && update_config "SCREENSHOT_FOLDER" "$new_val"
        ;;
    *Reload*)
        notify-send "⚙️ Ricing Pro" "Reloading Hyprland & Waybar..."
        $HOME/.config/hypr/scripts/loadconfig.sh
        ;;
esac

exit 0

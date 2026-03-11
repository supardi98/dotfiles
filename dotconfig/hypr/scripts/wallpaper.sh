#!/usr/bin/env bash
# 🚀 Project Ricing - Standalone Wallpaper Script

# Source library.sh
source $HOME/.config/hypr/scripts/library.sh

# Notifications
source "$HOME/.config/hypr/scripts/notification-handler.sh"
APP_NAME="Ricing Pro"
NOTIFICATION_ICON="preferences-desktop-wallpaper-symbolic"

# -----------------------------------------------------
# Check to use wallpaper cache
# -----------------------------------------------------
if [ -f ~/.config/hypr/settings/wallpaper_cache ]; then
    use_cache=1
    _writeLog "Using Wallpaper Cache"
else
    use_cache=0
    _writeLog "Wallpaper Cache disabled"
fi

# -----------------------------------------------------
# Create cache folder
# -----------------------------------------------------
project_cache_folder="$HOME/.cache/hyprland-dotfiles"
mkdir -p "$project_cache_folder"
generatedversions="$project_cache_folder/wallpaper-generated"
mkdir -p "$generatedversions"

# Path config
cachefile="$project_cache_folder/current_wallpaper"
blurredwallpaper="$project_cache_folder/blurred_wallpaper.png"
squarewallpaper="$project_cache_folder/square_wallpaper.png"
rasifile="$project_cache_folder/current_wallpaper.rasi"
blurfile="$HOME/.config/hypr/settings/blur.sh"
defaultwallpaper="$HOME/.config/wallpapers/default.jpg"
wallpapereffect="$HOME/.config/hypr/settings/wallpaper-effect.sh"

# Default blur
blur="50x30"
if [ -f "$blurfile" ]; then
    blur=$(cat "$blurfile")
fi

# -----------------------------------------------------
# Get selected wallpaper
# -----------------------------------------------------
if [ -z "$1" ]; then
    if [ -f "$cachefile" ]; then
        wallpaper=$(cat "$cachefile")
        wallpaper=$(echo "$wallpaper" | sed 's/\\ / /g')
    else
        wallpaper="$defaultwallpaper"
    fi
else
    wallpaper="$1"
    wallpaper=$(echo "$wallpaper" | sed 's/\\ / /g')
fi

# Pastikan file ada
if [ ! -f "$wallpaper" ]; then
    wallpaper="$defaultwallpaper"
fi

echo "$wallpaper" > "$cachefile"
used_wallpaper="$wallpaper"
wallpaperfilename=$(basename "$wallpaper")

# -----------------------------------------------------
# Wallpaper Effects (Simplified)
# -----------------------------------------------------
if [ -f "$wallpapereffect" ]; then
    effect=$(cat "$wallpapereffect")
else
    effect="off"
fi

# Apply Wallpaper directly with awww
_writeLog "Applying wallpaper with awww: $used_wallpaper"
awww img "$used_wallpaper" --transition-type any

# -----------------------------------------------------
# Execute matugen
# -----------------------------------------------------
SETTINGS_FILE="$HOME/.config/gtk-3.0/settings.ini"
THEME_PREF=1
if [ -f "$SETTINGS_FILE" ]; then
    THEME_PREF=$(grep -E '^gtk-application-prefer-dark-theme=' "$SETTINGS_FILE" | awk -F'=' '{print $2}')
fi

_writeLog "Execute matugen with $used_wallpaper"
if [ "$THEME_PREF" -eq 1 ]; then
    $HOME/.local/bin/matugen image "$used_wallpaper" -m "dark"
else
    $HOME/.local/bin/matugen image "$used_wallpaper" -m "light"
fi

# Update SwayNC
swaync-client -rs

# -----------------------------------------------------
# Create Blurred and Rasi file (for Rofi)
# -----------------------------------------------------
magick "$used_wallpaper" -resize 75% "$blurredwallpaper"
if [ ! "$blur" == "0x0" ]; then
    magick "$blurredwallpaper" -blur "$blur" "$blurredwallpaper"
fi

echo "* { current-image: url(\"$blurredwallpaper\", height); }" > "$rasifile"
magick "$wallpaper" -gravity Center -extent 1:1 "$squarewallpaper"

notify-send "$APP_NAME" "Wallpaper changed to $wallpaperfilename" -i "$NOTIFICATION_ICON"

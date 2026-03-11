#!/usr/bin/env bash
# Project Ricing Waybar Toggle Script

if [ -f $HOME/.config/hypr/settings/waybar-disabled ]; then
    rm $HOME/.config/hypr/settings/waybar-disabled
    $HOME/.config/hypr/scripts/launch-waybar.sh &
else
    touch $HOME/.config/hypr/settings/waybar-disabled
    killall waybar || true
fi

#!/usr/bin/env bash
# Project Ricing Waybar Toggle Script

if [ -f $HOME/.config/ml4w/settings/waybar-disabled ]; then
    rm $HOME/.config/ml4w/settings/waybar-disabled
    $HOME/.config/hypr/scripts/launch-waybar.sh &
else
    touch $HOME/.config/ml4w/settings/waybar-disabled
    killall waybar || true
fi

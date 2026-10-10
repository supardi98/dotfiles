#!/usr/bin/env bash
# 🖐️ Smart 4-finger Swipe Down Handler
# If Overview is open, swipe down closes Overview.
# If Overview is NOT open, swipe down toggles Noctalia Launcher.

IS_OVERVIEW=$(niri msg -j overview-state 2>/dev/null | jq -r '.is_open // false')

if [ "$IS_OVERVIEW" = "true" ]; then
    # Tutup Overview (jangan buka launcher)
    niri msg action toggle-overview
else
    # Buka / toggle launcher
    noctalia msg panel-toggle launcher
fi

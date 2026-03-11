#!/usr/bin/env bash

# Count Pacman updates
if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

# Count AUR updates (if yay is installed)
if command -v yay &> /dev/null; then
    updates_aur=$(yay -Qua 2> /dev/null | wc -l)
else
    updates_aur=0
fi

total_updates=$((updates_arch + updates_aur))

if [ "$total_updates" -gt 0 ]; then
    echo "{\"text\": \"󰏗 $total_updates\", \"tooltip\": \"$total_updates updates available\", \"class\": \"updates\"}"
else
    echo ""
fi

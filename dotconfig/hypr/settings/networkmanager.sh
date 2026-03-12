#!/usr/bin/env bash
# 🌐 Launch Network Manager from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${TERMINAL:-kitty} --class dotfiles-floating -e ~/.config/hypr/scripts/ricing-network
else
    exec kitty --class dotfiles-floating -e ~/.config/hypr/scripts/ricing-network
fi

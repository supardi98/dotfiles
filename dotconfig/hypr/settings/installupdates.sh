#!/usr/bin/env bash
# 📦 Launch System Updates from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${TERMINAL:-kitty} --class dotfiles-floating -e ~/.config/hypr/scripts/ricing-install-system-updates
else
    exec kitty --class dotfiles-floating -e ~/.config/hypr/scripts/ricing-install-system-updates
fi

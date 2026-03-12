#!/usr/bin/env bash
# 🖥️ Launch System Monitor from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${TERMINAL:-kitty} --class dotfiles-floating -e btop
else
    exec kitty --class dotfiles-floating -e btop
fi

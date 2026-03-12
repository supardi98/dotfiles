#!/usr/bin/env bash
# 🖥️ Launch Terminal from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${TERMINAL:-kitty}
else
    exec kitty
fi

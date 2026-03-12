#!/usr/bin/env bash
# 🌐 Launch Browser from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${BROWSER:-firefox}
else
    exec firefox
fi

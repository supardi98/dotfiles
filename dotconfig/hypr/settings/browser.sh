#!/usr/bin/env bash
# 🌐 Launch Browser from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${BROWSER:-brave}
else
    exec brave
fi

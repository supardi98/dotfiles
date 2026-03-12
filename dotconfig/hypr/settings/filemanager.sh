#!/usr/bin/env bash
# 📂 Launch File Manager from ricing.conf

if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    exec ${FILEMANAGER:-nautilus}
else
    exec nautilus
fi

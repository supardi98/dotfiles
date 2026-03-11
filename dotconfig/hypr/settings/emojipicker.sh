#!/usr/bin/env bash
# ✨ Glassy Emoji Picker - Types directly into active window

if command -v rofimoji > /dev/null; then
    # --action type copy: Ketik langsung DAN salin ke clipboard
    rofimoji \
        --action type copy \
        --hidden-descriptions \
        --selector-args "-theme ~/.config/rofi/emoji.rasi -p "
else
    notify-send "Emoji Picker" "Silakan instal 'rofimoji' dan 'wtype' terlebih dahulu: sudo pacman -S rofimoji wtype"
fi

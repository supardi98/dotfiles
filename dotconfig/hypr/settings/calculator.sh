#!/usr/bin/env bash
# 󰪚 Rofi-Calc execution with auto-copy
rofi -modi calc -show calc \
    -no-show-match \
    -no-sort \
    -calc-command "echo -n '{result}' | wl-copy && notify-send 'Calculator' 'Result copied to clipboard: {result}'" \
    -theme ~/.config/rofi/calc.rasi

#!/usr/bin/env bash
# ⚡ Global Performance Mode Toggle (Super + Shift + P)
# Disables blur effects in Niri and wallpaper in Noctalia for maximum GPU & battery efficiency

PERF_FLAG="/tmp/niri_perf_mode.flag"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"
NOCTALIA_CONFIG="$HOME/.config/noctalia/config.toml"

if [ -f "$PERF_FLAG" ]; then
    # 🎨 Mode Performance sedang ON -> Kembalikan ke Normal Estetik
    rm -f "$PERF_FLAG"

    # Kembalikan blur di Niri
    sed -i --follow-symlinks 's/passes 0/passes 3/' "$NIRI_CONFIG"
    niri msg action load-config-file

    # Kembalikan wallpaper di Noctalia
    if [ -f "$NOCTALIA_CONFIG" ]; then
        sed -i --follow-symlinks 's/enabled = false # wallpaper-perf/enabled = true # wallpaper-perf/' "$NOCTALIA_CONFIG"
    fi
    noctalia msg wallpaper-random 2>/dev/null || true

    notify-send -u normal -i video-display -t 2500 "Visual Mode: Aesthetic 🎨" "Efek frosted glass blur & wallpaper diaktifkan kembali."
else
    # ⚡ Mode Normal -> Aktifkan Performance Mode
    touch "$PERF_FLAG"

    # Matikan blur di Niri (passes 0)
    sed -i --follow-symlinks 's/passes 3/passes 0/' "$NIRI_CONFIG"
    niri msg action load-config-file

    notify-send -u critical -i speedometer -t 2500 "Performance Mode: ON ⚡" "Blur dan efek berat dimatikan untuk efisiensi GPU/baterai."
fi

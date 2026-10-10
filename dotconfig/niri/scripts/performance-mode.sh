#!/usr/bin/env bash
# ⚡ Standard Performance Mode Toggle (Super + Shift + P)
# Disables GPU blur while preserving your wallpaper and window opacities

PERF_FLAG="/tmp/niri_perf_mode.flag"
EXTREME_FLAG="/tmp/niri_extreme_perf.flag"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"

# Jika extreme mode sedang aktif, bersihkan dulu
if [ -f "$EXTREME_FLAG" ]; then
    bash "$HOME/.config/niri/scripts/extreme-performance.sh" "clean"
fi

if [ -f "$PERF_FLAG" ]; then
    # Mode Performance sedang ON -> Kembalikan ke Normal Estetik (Blur ON)
    rm -f "$PERF_FLAG"

    # Kembalikan blur di Niri
    sed -i --follow-symlinks 's/passes 0/passes 3/' "$NIRI_CONFIG"
    niri msg action load-config-file

    notify-send -u normal -i video-display -t 2500 "Visual Mode: Aesthetic 🎨" "Efek frosted glass blur aktif kembali (Wallpaper tetap aman)."
else
    # Mode Normal -> Aktifkan Standard Performance Mode (Blur OFF)
    touch "$PERF_FLAG"

    # Matikan blur di Niri (passes 0)
    sed -i --follow-symlinks 's/passes 3/passes 0/' "$NIRI_CONFIG"
    niri msg action load-config-file

    notify-send -u critical -i speedometer -t 2500 "Performance Mode: ON ⚡" "Blur GPU dimatikan (Baterai & GPU ringan, wallpaper tetap terlihat)."
fi

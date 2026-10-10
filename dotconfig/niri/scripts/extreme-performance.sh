#!/usr/bin/env bash
# 🚀 Extreme Performance / Battery Saver Mode Toggle (Super + Ctrl + P)
# Disables blur, sets background to pure solid black, and disables animations

EXTREME_FLAG="/tmp/niri_extreme_perf.flag"
PERF_FLAG="/tmp/niri_perf_mode.flag"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"
ORIGINAL_WP_FILE="/tmp/niri_saved_wallpaper.txt"

clean_state() {
    rm -f "$EXTREME_FLAG"
    # Kembalikan blur
    sed -i --follow-symlinks 's/passes 0/passes 3/' "$NIRI_CONFIG"
    # Kembalikan animasi slowdown
    sed -i --follow-symlinks 's/slowdown 0.01/slowdown 0.9/' "$NIRI_CONFIG"
    niri msg action load-config-file
    
    # Kembalikan wallpaper sebelumnya
    if [ -f "$ORIGINAL_WP_FILE" ]; then
        SAVED_WP=$(cat "$ORIGINAL_WP_FILE")
        if [ -f "$SAVED_WP" ]; then
            noctalia msg wallpaper-set "$SAVED_WP" 2>/dev/null || true
        fi
        rm -f "$ORIGINAL_WP_FILE"
    fi
}

if [ "$1" = "clean" ]; then
    clean_state
    exit 0
fi

if [ -f "$EXTREME_FLAG" ]; then
    # Sedang Extreme -> Kembalikan ke Normal
    clean_state
    notify-send -u normal -i video-display -t 2500 "Visual Mode: Aesthetic 🎨" "Extreme mode dinonaktifkan. Wallpaper & animasi kembali normal."
else
    # Sedang Normal -> Aktifkan Extreme Mode
    touch "$EXTREME_FLAG"
    rm -f "$PERF_FLAG" # bersihkan standard perf flag

    # Simpan wallpaper aktif saat ini
    CURRENT_WP=$(noctalia msg wallpaper-get 2>/dev/null || echo "")
    if [ -n "$CURRENT_WP" ]; then
        echo "$CURRENT_WP" > "$ORIGINAL_WP_FILE"
    fi

    # Matikan blur di Niri
    sed -i --follow-symlinks 's/passes 3/passes 0/' "$NIRI_CONFIG"
    # Jadikan animasi instan (tanpa beban rendering pegas)
    sed -i --follow-symlinks 's/slowdown 0.9/slowdown 0.01/' "$NIRI_CONFIG"
    niri msg action load-config-file

    notify-send -u critical -i battery-low -t 3000 "EXTREME Performance: ON 🚀" "Pure Performance: Blur OFF, Animasi Instan, Beban GPU Minimal!"
fi

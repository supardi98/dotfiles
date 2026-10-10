#!/usr/bin/env bash
# 🚀 Extreme Performance / Battery Saver Mode Toggle (Super + Ctrl + P)
# Disables blur, sets background to pure solid black, forces solid opacity, and disables animations

EXTREME_FLAG="/tmp/niri_extreme_perf.flag"
PERF_FLAG="/tmp/niri_perf_mode.flag"
NIRI_CONFIG="$HOME/.config/niri/config.kdl"
ORIGINAL_WP_FILE="/tmp/niri_saved_wallpaper.txt"
SOLID_BLACK_WP="$HOME/Projects/dotfiles/dotconfig/wallpapers/solid-black.png"

# Deteksi nama monitor yang aktif (eDP-1)
CONNECTOR=$(niri msg -j outputs | jq -r 'keys[0] // "eDP-1"')

clean_state() {
    rm -f "$EXTREME_FLAG"
    # Kembalikan blur di Niri
    sed -i --follow-symlinks 's/passes 0/passes 3/' "$NIRI_CONFIG"
    # Kembalikan animasi normal
    sed -i --follow-symlinks 's/slowdown 0.01/slowdown 0.9/' "$NIRI_CONFIG"
    # Nonaktifkan include extreme-perf.kdl
    sed -i --follow-symlinks 's|^include "extreme-perf.kdl"|// include "extreme-perf.kdl"|' "$NIRI_CONFIG"
    niri msg action load-config-file
    
    # Kembalikan wallpaper sebelumnya
    if [ -f "$ORIGINAL_WP_FILE" ]; then
        SAVED_WP=$(cat "$ORIGINAL_WP_FILE")
        if [ -n "$SAVED_WP" ] && [ -f "$SAVED_WP" ]; then
            noctalia msg wallpaper-set "$CONNECTOR" "$SAVED_WP" 2>/dev/null || true
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
    notify-send -u normal -i video-display -t 2500 "Visual Mode: Aesthetic 🎨" "Extreme mode nonaktif. Wallpaper, blur & animasi kembali normal."
else
    # Sedang Normal -> Aktifkan Extreme Mode
    touch "$EXTREME_FLAG"
    rm -f "$PERF_FLAG" # bersihkan standard perf flag

    # Simpan wallpaper aktif saat ini jika belum tersimpan
    if [ ! -f "$ORIGINAL_WP_FILE" ]; then
        CURRENT_WP=$(noctalia msg wallpaper-get "$CONNECTOR" 2>/dev/null || echo "")
        if [ -n "$CURRENT_WP" ] && [ -f "$CURRENT_WP" ] && [[ "$CURRENT_WP" != *"solid-black"* ]]; then
            echo "$CURRENT_WP" > "$ORIGINAL_WP_FILE"
        else
            echo "$HOME/Projects/dotfiles/dotconfig/wallpapers/1363137.png" > "$ORIGINAL_WP_FILE"
        fi
    fi

    # Set background menjadi Full Black murni ke monitor spesifik
    if [ -f "$SOLID_BLACK_WP" ]; then
        noctalia msg wallpaper-set "$CONNECTOR" "$SOLID_BLACK_WP" 2>/dev/null || true
    fi

    # Matikan blur di Niri
    sed -i --follow-symlinks 's/passes 3/passes 0/' "$NIRI_CONFIG"
    # Jadikan animasi instan (0.01)
    sed -i --follow-symlinks 's/slowdown 0.9/slowdown 0.01/' "$NIRI_CONFIG"
    # Aktifkan include extreme-perf.kdl (Solid 100% Opacity)
    if grep -q "^// include \"extreme-perf.kdl\"" "$NIRI_CONFIG"; then
        sed -i --follow-symlinks 's|^// include "extreme-perf.kdl"|include "extreme-perf.kdl"|' "$NIRI_CONFIG"
    elif ! grep -q "extreme-perf.kdl" "$NIRI_CONFIG"; then
        echo 'include "extreme-perf.kdl"' >> "$NIRI_CONFIG"
    fi

    niri msg action load-config-file

    notify-send -u critical -i battery-low -t 3000 "EXTREME Performance: ON 🚀" "Full Black murni, Solid Opacity 100%, Blur OFF, Beban GPU 0%!"
fi

#!/usr/bin/env bash
# 🚀 Niri + Noctalia Shell Reload Script

# Kirim notifikasi awal
notify-send -u low -t 2000 "System" "Reloading Niri & Noctalia..."

# Update Niri colors from Noctalia colors.json (Runtime Colors)
if command -v jq >/dev/null 2>&1; then
    COLORS_FILE="$HOME/.config/noctalia/colors.json"
    
    if [ -f "$COLORS_FILE" ]; then
        # Ambil mPrimary (ini warna yang benar-benar tampil di bar sekarang)
        PRIMARY_COLOR=$(jq -r '.mPrimary // empty' "$COLORS_FILE")
        
        if [ ! -z "$PRIMARY_COLOR" ] && [[ "$PRIMARY_COLOR" =~ ^# ]]; then
            # Update file ASLI di folder dotfiles (ini jalur yang paling aman)
            DOT_CONFIG_FILE="/home/supardi/Projects/ricing/dotconfig/niri/config.kdl"
            if [ -f "$DOT_CONFIG_FILE" ]; then
                sed -i "s/active-color \".*\" \/\/ Updated via reload.sh/active-color \"$PRIMARY_COLOR\" \/\/ Updated via reload.sh/" "$DOT_CONFIG_FILE"
            fi
        fi
    fi
fi

# Reload Niri
niri msg action load-config-file

# Restart Noctalia Shell
pkill -f "quickshell"
pkill -f "noctalia-shell"
pkill -f "qs -c noctalia-shell"

# Matikan daemon notifikasi lain agar Noctalia bisa mengambil alih
pkill swaync
pkill mako

sleep 0.5

# Jalankan kembali di background
qs -c noctalia-shell > /dev/null 2>&1 &

# Tunggu sampai notification daemon aktif (cek setiap 0.1 detik, max 5 detik)
for i in {1..50}; do
    if busctl --user status org.freedesktop.Notifications >/dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

# Kirim notifikasi selesai
notify-send -u normal -t 3000 "System" "Reload complete! ✨"

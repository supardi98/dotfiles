#!/usr/bin/env bash
# 🚀 Niri + Noctalia Shell Reload Script

# Kirim notifikasi awal
notify-send -u low -t 2000 "System" "Reloading Niri & Noctalia..." || true

# 🎨 Update Niri colors from Noctalia
if command -v jq >/dev/null 2>&1; then
    COLORS_FILE="$HOME/.config/noctalia/colors.json"
    if [ -f "$COLORS_FILE" ]; then
        PRIMARY_COLOR=$(jq -r '.mPrimary // empty' "$COLORS_FILE")
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        DOT_CONFIG_FILE="$(dirname "$SCRIPT_DIR")/config.kdl"
        if [ ! -z "$PRIMARY_COLOR" ] && [[ "$PRIMARY_COLOR" =~ ^# ]] && [ -f "$DOT_CONFIG_FILE" ]; then
            # Gunakan --follow-symlinks agar tidak merusak link dotfiles
            sed -i --follow-symlinks "s/active-color \".*\" \/\/ Updated via reload.sh/active-color \"$PRIMARY_COLOR\" \/\/ Updated via reload.sh/" "$DOT_CONFIG_FILE"
        fi
    fi
fi

# 🔄 Restart xsettingsd to apply theme to XWayland/older apps
# xsettingsd.conf sudah kita update untuk menggunakan adw-gtk3-dark
pkill xsettingsd
xsettingsd &

# Fix File Picker to use GNOME Portal

systemctl --user stop xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal 2>/dev/null || true
systemctl --user start xdg-desktop-portal-gnome xdg-desktop-portal

# Reload Niri
niri msg action load-config-file

# 🐚 Restart Noctalia Shell
pkill -f "quickshell"
pkill -f "noctalia-shell"
pkill -f "qs -c noctalia-shell"

# Matikan daemon notifikasi lain
pkill swaync
pkill mako

sleep 0.5

# Jalankan kembali di background
qs -c noctalia-shell > /dev/null 2>&1 &

# Tunggu sampai notification daemon aktif
for i in {1..50}; do
    if busctl --user status org.freedesktop.Notifications >/dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

# Kirim notifikasi selesai
notify-send -u normal -t 3000 "System" "Reload complete! ✨"

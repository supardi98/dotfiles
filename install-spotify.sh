#!/usr/bin/env bash
# 🎵 Spotify & Customization Installer (Spicetify + Tray)

set -e

echo "=== MEMULAI INSTALASI SPOTIFY PRO SETUP ==="

# 1. Instal Spotify & Tray via AUR
echo "📦 Menginstal Spotify dan Spotify Tray Wayland..."
yay -S --needed --noconfirm spotify spotify-tray-wayland-bin spicetify-cli

# 2. Jalankan skrip penerapan tema
if [ -f "./apply-spotify-theme.sh" ]; then
    echo "🎨 Menerapkan tema Spotify..."
    chmod +x apply-spotify-theme.sh
    ./apply-spotify-theme.sh
else
    echo "⚠️ Skrip apply-spotify-theme.sh tidak ditemukan!"
fi

echo ""
echo "=== SELESAI! ==="
echo "Spotify sekarang sudah cantik dan memiliki ikon tray."
echo "Silakan buka Spotify dan jalankan 'spotify-tray-wayland &' di terminal jika belum muncul."

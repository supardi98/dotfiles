#!/usr/bin/env bash
# 🚀 Ultimate Dotfiles Installer for Hyprland & Zsh Pro

set -e # Berhenti jika ada error

echo "=== MEMULAI INSTALASI DOTFILES ==="

# 1. Periksa apakah sistem berbasis Arch
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: Skrip ini didesain khusus untuk Arch Linux atau turunannya (CachyOS, Manjaro, EndevourOS)."
    exit 1
fi

# 2. Update Sistem & Instal Paket Utama
echo "📦 Mengupdate sistem dan menginstal paket yang dibutuhkan..."
PACKAGES=(
    # Core Desktop
    hyprland hyprlock hypridle kitty waybar rofi-wayland swaync awww 
    # Terminal Productivity
    eza bat zoxide fzf lazygit yazi btop trash-cli tealdeer jq direnv nvim rofimoji wtype
    # Fonts & Icons
    ttf-jetbrains-mono-nerd
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# 2.1 Instal ML4W Apps via Flatpak
echo "📦 Menginstal ML4W Apps via Flatpak..."
if command -v flatpak > /dev/null; then
    flatpak remote-add --if-not-exists ml4w-repo https://ml4w.github.io/flatpak/repo/ml4w-repo.flatpakrepo
    flatpak install --noninteractive ml4w-repo com.ml4w.settings com.ml4w.calendar || echo "⚠️ Flatpak apps install failed, skipping."
else
    echo "⚠️ Flatpak tidak ditemukan, silakan instal flatpak dulu jika ingin aplikasi ML4W."
fi

# 3. Inisialisasi Tealdeer (tldr)
echo "📖 Mengupdate database tldr..."
tldr --update || echo "⚠️ Gagal mengupdate tldr, abaikan saja."

# 4. Berikan izin eksekusi pada skrip pendukung
echo "🔑 Memberikan izin eksekusi pada skrip..."
chmod +x apply.sh
find dotconfig/hypr/scripts -type f -name "*.sh" -exec chmod +x {} +

# 5. Jalankan apply.sh untuk setup symlinks
echo "🔗 Menjalankan apply.sh untuk menghubungkan konfigurasi..."
./apply.sh

echo ""
echo "=== SELESAI! ==="
echo "Semua aplikasi telah terinstal dan konfigurasi telah diterapkan."
echo "Silakan restart Hyprland (Super+Shift+Q) dan buka terminal baru."
echo "Selamat menikmati terminal 'Pro' baru Anda! 🚀"

#!/usr/bin/env bash
# 🚀 Ultimate Dotfiles Installer for Hyprland, Zsh, Bash & Fish Pro

set -e # Berhenti jika ada error

echo "=== MEMULAI INSTALASI DOTFILES ==="

# 1. Periksa apakah sistem berbasis Arch
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: Skrip ini didesain khusus untuk Arch Linux atau turunannya (CachyOS, Manjaro, EndevourOS)."
    exit 1
fi

# 2. Update Sistem & Instal Paket Utama
echo "📦 Mengupdate sistem dan menginstal paket yang dibutuhkan..."

# Daftar paket dari repositori resmi
PACKAGES=(
    # Core Desktop & Window Manager
    hyprland hyprlock hypridle kitty waybar rofi-wayland swaync awww flatpak 
    bluez bluez-utils blueman rofi-calc networkmanager qt6ct xsettingsd 
    hyprpicker hyprshade playerctl grim slurp wl-clipboard waypaper
    # File Manager & Browser
    nautilus brave-bin
    # Shells
    zsh fish
    # Terminal Productivity
    eza bat zoxide fzf lazygit yazi btop trash-cli tealdeer jq direnv nvim rofimoji wtype
    # Fonts & Icons
    ttf-jetbrains-mono-nerd
)

# Catatan: Beberapa paket seperti brave-bin, grimblast-git, swayosd-git, cliphist 
# mungkin perlu diinstal via AUR jika tidak ada di repo resmi distro Anda.
# Kami akan mencoba menginstal paket yang tersedia di repo resmi terlebih dahulu.

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}" || echo "⚠️ Beberapa paket mungkin tidak tersedia di repositori resmi, silakan instal via AUR (yay/paru)."

# 2.1 Instal Matugen (Warna Dinamis)
if ! command -v matugen &> /dev/null; then
    echo "🎨 Menginstal Matugen..."
    mkdir -p ~/.local/bin
    curl -L https://github.com/InSyncWithYouself/matugen/releases/latest/download/matugen-linux-x86_64 -o ~/.local/bin/matugen
    chmod +x ~/.local/bin/matugen
fi

# 2.2 Instal Oh My Posh (Prompt)
if ! command -v oh-my-posh &> /dev/null; then
    echo "✨ Menginstal Oh My Posh..."
    mkdir -p ~/.local/bin
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

# 3 Aktifkan Bluetooth Service
echo "🔵 Mengaktifkan layanan Bluetooth..."
sudo systemctl enable --now bluetooth || echo "⚠️ Gagal mengaktifkan bluetooth, abaikan jika tidak ada hardwarenya."

# 4. Aktifkan NetworkManager
echo "🌐 Memastikan NetworkManager aktif..."
sudo systemctl enable --now NetworkManager || true

# 5. Inisialisasi Tealdeer (tldr)
echo "📖 Mengupdate database tldr..."
tldr --update || echo "⚠️ Gagal mengupdate tldr, abaikan saja."

# 6. Berikan izin eksekusi pada skrip pendukung
echo "🔑 Memberikan izin eksekusi pada skrip..."
chmod +x apply.sh
chmod +x apply-spotify-theme.sh
chmod +x install-spotify.sh
find dotconfig/hypr/scripts -type f -name "*.sh" -exec chmod +x {} +
chmod +x dotconfig/waybar/launch.sh

# 7. Instal aplikasi tambahan (Kalender & Settings GUI)
if command -v flatpak &> /dev/null; then
    echo "📦 Menginstal Aplikasi Pendukung (Kalender & Settings GUI)..."
    flatpak remote-add --if-not-exists ml4w-repo https://ml4w.github.io/flatpak/repo/ml4w-repo.flatpakrepo
    flatpak install --noninteractive ml4w-repo com.ml4w.calendar com.ml4w.settings || true
fi

# 8. Jalankan apply.sh untuk setup symlinks
echo "🔗 Menjalankan apply.sh untuk menghubungkan konfigurasi..."
./apply.sh

echo ""
echo "=== SELESAI! ==="
echo "Semua aplikasi telah terinstal dan konfigurasi telah diterapkan."
echo "Anda dapat menggunakan perintah 'chsh' atau menu Tools untuk mengubah shell default."
echo "Silakan restart Hyprland (Super+Shift+Q) dan buka terminal baru."
echo "Selamat menikmati pengalaman Ricing Pro Anda! 🚀"

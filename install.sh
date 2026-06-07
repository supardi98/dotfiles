#!/usr/bin/env bash
# 🚀 Ultimate Dotfiles Installer for Niri + Noctalia Shell Pro

set -e # Berhenti jika ada error

echo "=== MEMULAI INSTALASI DOTFILES (Niri Edition) ==="

# 1. Periksa apakah sistem berbasis Arch
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: Skrip ini didesain khusus untuk Arch Linux atau turunannya (CachyOS, Manjaro, EndeavourOS)."
    exit 1
fi

# 2. Update Sistem & Instal Paket Utama
echo "📦 Mengupdate sistem dan menginstal paket yang dibutuhkan..."

# Daftar paket utama
PACKAGES=(
    # Core Desktop & Window Manager
    niri noctalia-shell matugen
    kitty bluez bluez-utils blueman networkmanager network-manager-applet qt6ct xsettingsd 
    playerctl grim slurp wl-clipboard swaybg jq cliphist
    # File Manager, Browser & Core Apps
    nautilus brave gnome-calculator loupe gnome-text-editor
    evince gnome-system-monitor baobab
    # Modified Apps (AUR)
    spotify visual-studio-code-bin
    # Theme & Portal
    xdg-desktop-portal-gnome xdg-desktop-portal-gtk papirus-icon-theme
    # Shells
    zsh fish bash-completion
    # Terminal Productivity
    eza bat zoxide fzf lazygit yazi btop trash-cli tealdeer direnv nvim
    # Fonts
    ttf-jetbrains-mono-nerd ttf-apple-emoji
    # GNOME Keyring
    gnome-keyring libsecret
)

# Gunakan yay jika tersedia, jika tidak pakai pacman
if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm "${PACKAGES[@]}"
else
    sudo pacman -S --needed --noconfirm "${PACKAGES[@]}" || echo "⚠️ Beberapa paket mungkin butuh AUR (yay/paru)."
fi

# 2.2 Instal Oh My Posh (Prompt)
if ! command -v oh-my-posh &> /dev/null; then
    echo "✨ Menginstal Oh My Posh..."
    mkdir -p ~/.local/bin
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

# 2.3 Instal Oh My Zsh & Plugins
if [ ! -d ~/.oh-my-zsh ]; then
    echo "ZSH: Menginstal Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
echo "ZSH: Menginstal/Update Plugins..."
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] && git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"

# 2.4 Set Zsh sebagai Default Shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Mengatur Zsh sebagai shell default..."
    sudo chsh -s "$(which zsh)" "$USER"
fi

# 3 Aktifkan Bluetooth Service
echo "🔵 Mengaktifkan layanan Bluetooth..."
sudo systemctl enable --now bluetooth || echo "⚠️ Gagal mengaktifkan bluetooth."

# 4. Aktifkan NetworkManager
echo "🌐 Memastikan NetworkManager aktif..."
sudo systemctl enable --now NetworkManager || true

# 5. Inisialisasi Tealdeer (tldr)
echo "📖 Mengupdate database tldr..."
tldr --update || echo "⚠️ Gagal mengupdate tldr."

# 5.1 Prioritaskan Emoji Apple
echo "🍎 Mengaktifkan konfigurasi Emoji Apple..."
sudo ln -sf /usr/share/fontconfig/conf.avail/75-apple-color-emoji.conf /etc/fonts/conf.d/ || true
fc-cache -f > /dev/null 2>&1 || true

# 6. Berikan izin eksekusi pada skrip pendukung
echo "🔑 Memberikan izin eksekusi pada skrip..."
chmod +x apply.sh
chmod +x apply-spotify-theme.sh
chmod +x install-spotify.sh
chmod +x apply-sddm-theme.sh
find dotconfig/niri/scripts -type f -name "*.sh" -exec chmod +x {} +

# 7. Jalankan apply.sh untuk setup symlinks
echo "🔗 Menjalankan apply.sh untuk menghubungkan konfigurasi..."
./apply.sh

# 8. Jalankan apply-sddm-theme.sh
echo "🎨 Menerapkan tema SDDM..."
./apply-sddm-theme.sh

echo ""
echo "=== SELESAI! ==="
echo "Semua aplikasi telah terinstal dan konfigurasi Niri + Noctalia telah diterapkan."
echo "Silakan restart sesi dan pilih 'Niri' di layar login."
echo "Selamat menikmati pengalaman Niri Pro Anda! 🚀"

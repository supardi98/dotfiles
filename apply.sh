#!/usr/bin/env bash
# Dotfiles Installation Script (Niri + Noctalia Edition)

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "=== Menerapkan Konfigurasi Dotfiles (Niri + Noctalia) ==="
echo "Dotfiles Path: $DOTFILES_DIR"

# Function to safely link configurations
link_config() {
    local src=$1
    local dest=$2

    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            echo "Menghapus symlink lama: $dest"
            rm "$dest"
        else
            echo "Mencadangkan folder asli: $dest -> ${dest}.bak"
            mv "$dest" "${dest}.bak"
        fi
    fi

    echo "Menghubungkan: $src -> $dest"
    ln -s "$src" "$dest"
}

# 1. Niri & Noctalia (Core)
link_config "$DOTFILES_DIR/dotconfig/niri" "$CONFIG_DIR/niri"
link_config "$DOTFILES_DIR/dotconfig/noctalia" "$CONFIG_DIR/noctalia"

# 2. Terminal & Shells
link_config "$DOTFILES_DIR/dotconfig/kitty" "$CONFIG_DIR/kitty"
link_config "$DOTFILES_DIR/dotconfig/fish" "$CONFIG_DIR/fish"

# 2.1 Setup .zshrc
echo "🐚 Mengonfigurasi .zshrc..."
if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak
    echo "Backup .zshrc dibuat."
fi
cat <<EOF > ~/.zshrc
# Auto-generated .zshrc (sources dotfiles)
for file in $DOTFILES_DIR/dotconfig/zshrc/custom/*; do
    [ -f "\$file" ] && source "\$file"
done
EOF

# 2.2 Setup .bashrc
echo "🐚 Mengonfigurasi .bashrc..."
if [ -f ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
    echo "Backup .bashrc dibuat."
fi
cat <<EOF > ~/.bashrc
# Auto-generated .bashrc (sources dotfiles)
for file in $DOTFILES_DIR/dotconfig/bashrc/*; do
    [ -f "\$file" ] && source "\$file"
done
EOF

# 3. System Tools
link_config "$DOTFILES_DIR/dotconfig/btop" "$CONFIG_DIR/btop"
link_config "$DOTFILES_DIR/dotconfig/fastfetch" "$CONFIG_DIR/fastfetch"
link_config "$DOTFILES_DIR/dotconfig/matugen" "$CONFIG_DIR/matugen"
link_config "$DOTFILES_DIR/dotconfig/ohmyposh" "$CONFIG_DIR/ohmyposh"

# 4. Appearance
link_config "$DOTFILES_DIR/dotconfig/gtk-3.0" "$CONFIG_DIR/gtk-3.0"
link_config "$DOTFILES_DIR/dotconfig/gtk-4.0" "$CONFIG_DIR/gtk-4.0"
link_config "$DOTFILES_DIR/dotconfig/qt6ct" "$CONFIG_DIR/qt6ct"
link_config "$DOTFILES_DIR/dotconfig/xsettingsd" "$CONFIG_DIR/xsettingsd"
link_config "$DOTFILES_DIR/dotconfig/wallpapers" "$CONFIG_DIR/wallpapers"

# 5. Default Applications
echo "📂 Mengatur aplikasi default..."
IMAGE_MIMES=("image/png" "image/jpeg" "image/jpg" "image/gif" "image/webp" "image/bmp" "image/tiff")
for mime in "${IMAGE_MIMES[@]}"; do
    xdg-mime default org.gnome.Loupe.desktop "$mime"
done

echo "=== SELESAI ==="
echo "Konfigurasi sekarang sepenuhnya diambil dari $DOTFILES_DIR"
echo "Silakan gunakan SUPER+SHIFT+R untuk mereload sesi Niri Anda."

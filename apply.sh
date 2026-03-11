#!/usr/bin/env bash
# Dotfiles Installation Script

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "=== Menerapkan Konfigurasi Dotfiles ==="
echo "Dotfiles Path: $DOTFILES_DIR"

# Ensure ~/.config exists
mkdir -p "$CONFIG_DIR"

# Function to create symlink with backup
link_config() {
    local src="$1"
    local dst="$2"
    
    # Ensure destination parent directory exists
    mkdir -p "$(dirname "$dst")"
    
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ ! -L "$dst" ]; then
            echo "Membuat backup: $dst -> $dst.bak"
            mv "$dst" "$dst.bak"
        else
            echo "Menghapus symlink lama: $dst"
            rm "$dst"
        fi
    fi
    
    echo "Menghubungkan: $src -> $dst"
    ln -s "$src" "$dst"
}

# 1. Hyprland (including conf/, scripts/ and settings/)
link_config "$DOTFILES_DIR/dotconfig/hypr" "$CONFIG_DIR/hypr"

# 2. Waybar
link_config "$DOTFILES_DIR/dotconfig/waybar" "$CONFIG_DIR/waybar"

# 3. Kitty
link_config "$DOTFILES_DIR/dotconfig/kitty" "$CONFIG_DIR/kitty"

# 4. Fastfetch
link_config "$DOTFILES_DIR/dotconfig/fastfetch" "$CONFIG_DIR/fastfetch"

# 5. SwayNC
link_config "$DOTFILES_DIR/dotconfig/swaync" "$CONFIG_DIR/swaync"

# 6. Rofi
link_config "$DOTFILES_DIR/dotconfig/rofi" "$CONFIG_DIR/rofi"

# 7. Wlogout
link_config "$DOTFILES_DIR/dotconfig/wlogout" "$CONFIG_DIR/wlogout"

echo "=== SELESAI ==="
echo "Konfigurasi sekarang sepenuhnya diambil dari $DOTFILES_DIR"
echo "Silakan restart Hyprland (Super+Shift+Q atau Logout) untuk melihat hasilnya."

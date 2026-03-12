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

# 3a. Btop
link_config "$DOTFILES_DIR/dotconfig/btop" "$CONFIG_DIR/btop"

# 4. Fastfetch
link_config "$DOTFILES_DIR/dotconfig/fastfetch" "$CONFIG_DIR/fastfetch"

# 5. SwayNC
link_config "$DOTFILES_DIR/dotconfig/swaync" "$CONFIG_DIR/swaync"

# 6. Rofi
link_config "$DOTFILES_DIR/dotconfig/rofi" "$CONFIG_DIR/rofi"

# 7. Wlogout
link_config "$DOTFILES_DIR/dotconfig/wlogout" "$CONFIG_DIR/wlogout"

# 7a. Waypaper
link_config "$DOTFILES_DIR/dotconfig/waypaper" "$CONFIG_DIR/waypaper"

# 8. Oh My Posh (Prompt)
link_config "$DOTFILES_DIR/dotconfig/ohmyposh" "$CONFIG_DIR/ohmyposh"

# 10. Spicetify
link_config "$DOTFILES_DIR/dotconfig/spicetify" "$CONFIG_DIR/spicetify"

# 11. Shell Configurations (Zsh, Bash, Fish)
link_config "$DOTFILES_DIR/dotconfig/zshrc" "$CONFIG_DIR/zshrc"
link_config "$DOTFILES_DIR/dotconfig/bashrc" "$CONFIG_DIR/bashrc"
link_config "$DOTFILES_DIR/dotconfig/fish" "$CONFIG_DIR/fish"

# 12. Wallpapers
link_config "$DOTFILES_DIR/dotconfig/wallpapers" "$CONFIG_DIR/wallpapers"

# 13. Matugen, GTK, Xsettingsd & Qt6ct Settings
link_config "$DOTFILES_DIR/dotconfig/matugen" "$CONFIG_DIR/matugen"
link_config "$DOTFILES_DIR/dotconfig/gtk-3.0" "$CONFIG_DIR/gtk-3.0"
link_config "$DOTFILES_DIR/dotconfig/gtk-4.0" "$CONFIG_DIR/gtk-4.0"
link_config "$DOTFILES_DIR/dotconfig/xsettingsd" "$CONFIG_DIR/xsettingsd"
link_config "$DOTFILES_DIR/dotconfig/qt6ct" "$CONFIG_DIR/qt6ct"

# 14. Dotfiles Settings
link_config "$DOTFILES_DIR/dotconfig/ml4w" "$CONFIG_DIR/ml4w"

# 15. Other Configurations
link_config "$DOTFILES_DIR/dotconfig/chromium-flags.conf" "$CONFIG_DIR/chromium-flags.conf"
link_config "$DOTFILES_DIR/dotconfig/edge-flags.conf" "$CONFIG_DIR/edge-flags.conf"

echo "=== SELESAI ==="
echo "Konfigurasi sekarang sepenuhnya diambil dari $DOTFILES_DIR"
echo "Silakan restart Hyprland (Super+Shift+Q atau Logout) untuk melihat hasilnya."

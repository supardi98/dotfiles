#!/usr/bin/env bash
# Spotify / Spicetify Setup Script

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "=== Mengonfigurasi Spicetify ==="

# Function to create symlink (independent version)
link_spotify_config() {
    local src="$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ ! -L "$dst" ]; then
            echo "Membuat backup: $dst -> $dst.bak"
            mv "$dst" "$dst.bak"
        else
            rm "$dst"
        fi
    fi
    echo "Menghubungkan: $src -> $dst"
    ln -s "$src" "$dst"
}

# Symlink konfigurasi
link_spotify_config "$DOTFILES_DIR/dotconfig/spicetify" "$CONFIG_DIR/spicetify"

# Periksa apakah spicetify terpasang
if command -v spicetify &> /dev/null; then
    echo "Memberikan izin tulis ke /opt/spotify..."
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
    
    echo "Mengatur path Spotify di Spicetify..."
    spicetify config spotify_path /opt/spotify/
    
    echo "Menerapkan konfigurasi Spicetify..."
    spicetify apply -n || spicetify backup apply -n
else
    echo "Peringatan: spicetify-cli belum terpasang. Lewati konfigurasi Spotify."
fi

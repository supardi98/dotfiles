#!/usr/bin/env bash
# 🚀 SDDM Theme Application Script

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="sddm-astronaut-theme"
THEME_SRC="$DOTFILES_DIR/dotconfig/sddm/themes/$THEME_NAME"
THEME_DEST="/usr/share/sddm/themes/$THEME_NAME"

echo "=== Menerapkan Tema SDDM Astronaut ==="

# 1. Instal Dependensi
echo "📦 Menginstal dependensi SDDM..."
sudo pacman -S --needed --noconfirm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg

# 2. Salin Tema ke Folder Sistem
echo "📂 Menyalin tema ke /usr/share/sddm/themes/..."
sudo mkdir -p "$THEME_DEST"
sudo cp -r "$THEME_SRC"/* "$THEME_DEST"/

# 3. Instal Font
echo "Fonts: Menyalin font ke /usr/share/fonts/..."
sudo mkdir -p /usr/share/fonts/sddm-astronaut
sudo cp -r "$THEME_SRC/Fonts"/* /usr/share/fonts/sddm-astronaut/
fc-cache -f > /dev/null

# 4. Konfigurasi SDDM
echo "🔧 Mengatur tema di /etc/sddm.conf..."
sudo mkdir -p /etc/sddm.conf.d
echo "[Theme]
Current=$THEME_NAME" | sudo tee /etc/sddm.conf > /dev/null

# 5. Set default variant ke 'astronaut' di metadata
echo "🎨 Mengatur varian default ke 'astronaut'..."
sudo sed -i "s|^ConfigFile=.*|ConfigFile=Themes/astronaut.conf|" "$THEME_DEST/metadata.desktop"

# 6. Tambahkan aturan Sudoers untuk sinkronisasi wallpaper
echo "🔑 Menambahkan aturan sudoers untuk sinkronisasi wallpaper..."
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/cp * $THEME_DEST/Backgrounds/*, /usr/bin/sed -i * $THEME_DEST/Themes/*" | sudo tee /etc/sudoers.d/sddm-sync > /dev/null
sudo chmod 440 /etc/sudoers.d/sddm-sync

echo "=== SELESAI! ==="
echo "Tema SDDM telah diterapkan. Anda akan melihatnya saat logout atau restart."

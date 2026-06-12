#!/usr/bin/env bash
# 🚀 SDDM Theme Application Script (SilentSDDM Edition)

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="SilentSDDM"
THEME_SRC="$DOTFILES_DIR/dotconfig/sddm/themes/$THEME_NAME"
THEME_DEST="/usr/share/sddm/themes/$THEME_NAME"

echo "=== Menerapkan Tema $THEME_NAME ==="

# 1. Instal Dependensi
echo "📦 Menginstal dependensi SDDM..."
sudo pacman -S --needed --noconfirm qt6-svg qt6-declarative qt6-multimedia-ffmpeg

# 2. Salin Tema ke Folder Sistem
echo "📂 Menyalin tema ke $THEME_DEST..."
sudo mkdir -p "$THEME_DEST"
sudo cp -r "$THEME_SRC"/* "$THEME_DEST"/

# 3. Konfigurasi SDDM
echo "🔧 Mengatur tema dan kursor di /etc/sddm.conf..."
sudo mkdir -p /etc/sddm.conf.d
echo "[Theme]
Current=$THEME_NAME
CursorTheme=ArcStarry-cursors" | sudo tee /etc/sddm.conf > /dev/null

# 3.1 Pastikan Kursor ada di folder sistem agar terbaca oleh SDDM
if [ -d "$DOTFILES_DIR/dotconfig/icons/ArcStarry-cursors" ]; then
    echo "🖱️ Menyalin kursor ke /usr/share/icons..."
    sudo cp -r "$DOTFILES_DIR/dotconfig/icons/ArcStarry-cursors" /usr/share/icons/ 2>/dev/null || true
    
    # Force system-wide fallback (paling ampuh untuk SDDM)
    sudo mkdir -p /usr/share/icons/default
    echo "[Icon Theme]
Inherits=ArcStarry-cursors" | sudo tee /usr/share/icons/default/index.theme > /dev/null
fi

# 4. Tambahkan aturan Sudoers untuk sinkronisasi wallpaper
echo "🔑 Menambahkan aturan sudoers untuk sinkronisasi wallpaper..."
# Aturan untuk menyalin ke folder backgrounds dan mengedit file configs/default.conf
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/cp * $THEME_DEST/backgrounds/*, /usr/bin/sed -i * $THEME_DEST/configs/*" | sudo tee /etc/sudoers.d/sddm-sync > /dev/null
sudo chmod 440 /etc/sudoers.d/sddm-sync

# 5. Jalankan sinkronisasi awal
echo "🔄 Melakukan sinkronisasi wallpaper awal..."
if [ -f ~/.config/niri/scripts/sync-sddm-wall.sh ]; then
    ~/.config/niri/scripts/sync-sddm-wall.sh
fi

echo "=== SELESAI! ==="
echo "Tema $THEME_NAME telah diterapkan. Anda akan melihatnya saat logout atau restart."

#!/bin/bash

# Path Project
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HYPR="$HOME/.config/hypr"

echo "=== Menerapkan Konfigurasi Ricing Project ==="
echo "Project Path: $PROJECT_DIR"

# 0. Generate project_path.conf
echo "\$project_dir = $PROJECT_DIR" > "$PROJECT_DIR/conf/project_path.conf"

# Update path in hyprland.conf and conf/custom.conf
sed -i "s|\$project_dir = .*|\$project_dir = $PROJECT_DIR|g" "$PROJECT_DIR/hyprland.conf"
sed -i "s|\$project_dir = .*|\$project_dir = $PROJECT_DIR|g" "$PROJECT_DIR/conf/custom.conf"

# Update path in config.jsonc (Waybar)
sed -i "s|/home/supardi/Projects/ricing|$PROJECT_DIR|g" "$PROJECT_DIR/config.jsonc"

# Update path in conf/swaync/config.json
sed -i "s|/home/supardi/Projects/ricing|$PROJECT_DIR|g" "$PROJECT_DIR/conf/swaync/config.json"

# 1. Backup file hyprland.conf asli jika belum dibackup
if [ ! -f "$CONFIG_HYPR/hyprland.conf.bak" ]; then
    echo "Membuat backup konfigurasi asli..."
    mv "$CONFIG_HYPR/hyprland.conf" "$CONFIG_HYPR/hyprland.conf.bak"
fi

# 2. Hubungkan hyprland.conf project ke sistem
echo "Menghubungkan hyprland.conf ke sistem..."
ln -sf "$PROJECT_DIR/hyprland.conf" "$CONFIG_HYPR/hyprland.conf"

echo "=== SELESAI ==="
echo "Silakan restart Hyprland (Super+Shift+Q atau Logout) untuk melihat hasilnya secara penuh saat boot."
echo "Konfigurasi sekarang sepenuhnya diambil dari $PROJECT_DIR"

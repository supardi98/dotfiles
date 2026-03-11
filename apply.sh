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

# Update path in fastfetch/config.jsonc
sed -i "s|\$project_dir|$PROJECT_DIR|g" "$PROJECT_DIR/fastfetch/config.jsonc"

# 1. Backup file hyprland.conf asli jika belum dibackup
if [ ! -f "$CONFIG_HYPR/hyprland.conf.bak" ]; then
    echo "Membuat backup konfigurasi asli..."
    mv "$CONFIG_HYPR/hyprland.conf" "$CONFIG_HYPR/hyprland.conf.bak"
fi

# 2. Hubungkan hyprland.conf project ke sistem
echo "Menghubungkan hyprland.conf ke sistem..."
ln -sf "$PROJECT_DIR/hyprland.conf" "$CONFIG_HYPR/hyprland.conf"

# 3. Hubungkan fastfetch config project ke sistem
echo "Menghubungkan fastfetch config ke sistem..."
mkdir -p "$HOME/.config/fastfetch"
ln -sf "$PROJECT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# 4. Hubungkan hyprlock config project ke sistem
echo "Menghubungkan hyprlock.conf ke sistem..."
ln -sf "$PROJECT_DIR/conf/hyprlock.conf" "$CONFIG_HYPR/hyprlock.conf"

# 5. Hubungkan kitty config project ke sistem
echo "Menghubungkan kitty.conf ke sistem..."
mkdir -p "$HOME/.config/kitty"
ln -sf "$PROJECT_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# 6. Hubungkan hypridle config project ke sistem
echo "Menghubungkan hypridle.conf ke sistem..."
ln -sf "$PROJECT_DIR/conf/hypridle.conf" "$CONFIG_HYPR/hypridle.conf"

# 7. Hubungkan swaync config project ke sistem
echo "Menghubungkan swaync config ke sistem..."
mkdir -p "$HOME/.config/swaync"
ln -sf "$PROJECT_DIR/conf/swaync/config.json" "$HOME/.config/swaync/config.json"
ln -sf "$PROJECT_DIR/conf/swaync/style.css" "$HOME/.config/swaync/style.css"

# 8. Hubungkan rofi config project ke sistem
echo "Menghubungkan rofi config ke sistem..."
mkdir -p "$HOME/.config/rofi"
ln -sf "$PROJECT_DIR/conf/rofi/glassy.rasi" "$HOME/.config/rofi/config.rasi"

# 9. Hubungkan wlogout config project ke sistem
echo "Menghubungkan wlogout config ke sistem..."
mkdir -p "$HOME/.config/wlogout"
ln -sf "$PROJECT_DIR/conf/wlogout/layout" "$HOME/.config/wlogout/layout"
ln -sf "$PROJECT_DIR/conf/wlogout/style.css" "$HOME/.config/wlogout/style.css"
cp -r "$PROJECT_DIR/conf/wlogout/icons" "$HOME/.config/wlogout/"

# Update path in wlogout layout
sed -i "s|\$project_dir|$PROJECT_DIR|g" "$PROJECT_DIR/conf/wlogout/layout"

echo "=== SELESAI ==="
echo "Silakan restart Hyprland (Super+Shift+Q atau Logout) untuk melihat hasilnya secara penuh saat boot."
echo "Konfigurasi sekarang sepenuhnya diambil dari $PROJECT_DIR"

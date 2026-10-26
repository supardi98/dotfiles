#!/usr/bin/env bash
# 🚀 Docker Clean Startup Configuration Script
# Mencegah container auto-start saat Docker/PC dinyalakan tanpa mengubah config compose/always

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_CFG_DIR="$DOTFILES_DIR/dotconfig/docker"

echo "=== Memasang Konfigurasi Docker Clean Autostart ==="

# 1. Salin script helper ke /usr/local/bin
echo "📦 Menyalin script helper ke /usr/local/bin..."
sudo cp "$DOCKER_CFG_DIR/scripts/docker-prevent-autostart.sh" /usr/local/bin/
sudo cp "$DOCKER_CFG_DIR/scripts/docker-restore-autostart.sh" /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-prevent-autostart.sh /usr/local/bin/docker-restore-autostart.sh

# 2. Pasang Systemd Drop-in Override
echo "🔧 Memasang Systemd drop-in override..."
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cp "$DOCKER_CFG_DIR/systemd/override.conf" /etc/systemd/system/docker.service.d/override.conf

# 3. Reload systemd daemon
echo "🔄 Reload systemd..."
sudo systemctl daemon-reload

# 4. Enable docker service & socket saat startup
echo "⚡ Mengaktifkan Docker service saat startup..."
sudo systemctl enable docker.service
sudo systemctl enable docker.socket

echo "=== SELESAI! ==="
echo "Docker sekarang aktif saat boot tanpa menyalakan container secara otomatis."

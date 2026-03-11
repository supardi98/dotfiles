#!/usr/bin/env bash
# 🛠️ Ricing Pro - Tools Menu

# Konfigurasi Rofi
config_dir="$HOME/.config/rofi"
config_file="$config_dir/glassy-list.rasi"

# Ambil terminal dari setting
terminal=$(cat ~/.config/hypr/settings/terminal.sh)

# Daftar Tools
options="🎨 Color Picker (HEX)\n󰄀 Color Picker (RGB)\n󰃐 Hyprshade (Blue Light)\n󱖫 omcalc (Calculator)\n󰏆 Notes\n󰒓 Hyprland Settings"

# Ambil pilihan dari Rofi
choice=$(echo -e "$options" | rofi -dmenu -i -config "$config_file" -p "🛠️ Tools")

# Jika tidak ada pilihan (user menekan ESC), keluar
if [ -z "$choice" ]; then
    exit 0
fi

# Jalankan tool
case "$choice" in
    *HEX*)
        (sleep 0.5 && hyprpicker -a -f hex) &
        ;;
    *RGB*)
        (sleep 0.5 && hyprpicker -a -f rgb) &
        ;;
    *Hyprshade*)
        $HOME/.config/hypr/scripts/hyprshade.sh &
        ;;
    *omcalc*)
        omcalc &
        ;;
    *Notes*)
        $terminal --class dotfiles-floating -e nvim ~/notes.md &
        ;;
    *Settings*)
        flatpak run com.ml4w.hyprlandsettings &
        ;;
esac

# Paksa tutup Rofi agar layar bersih
pkill -x rofi
exit 0

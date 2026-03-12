#!/usr/bin/env bash
# 🛠️ Ricing Pro - Tools Menu

# Konfigurasi Rofi
config_dir="$HOME/.config/rofi"
config_file="$config_dir/glassy-list.rasi"

# Ambil terminal dari setting
if [ -f ~/.config/hypr/settings/ricing.conf ]; then
    source ~/.config/hypr/settings/ricing.conf
    terminal="${TERMINAL:-kitty}"
else
    terminal=$(cat ~/.config/hypr/settings/terminal.sh 2>/dev/null || echo "kitty")
fi

# Daftar Tools
options="📸 Take Screenshot\n⚙️ Ricing Config\n󰒓 Hyprland Settings\n󱖫 Rofi Calc (Calculator)\n🎨 Color Picker (HEX)\n󰄀 Color Picker (RGB)\n󰃐 Hyprshade (Blue Light)\n󰏆 Notes\n🐚 Change Shell"

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
    *Rofi*)
        ~/.config/hypr/settings/calculator.sh &
        ;;
    *Notes*)
        $terminal --class dotfiles-floating -e ${EDITOR:-nvim} ~/notes.md &
        ;;
    *Settings*)
        flatpak run com.ml4w.hyprlandsettings &
        ;;
    *Shell*)
        selected_shell=$(echo -e "bash\nzsh\nfish" | rofi -dmenu -i -config "$config_file" -p "🐚 Select Shell")
        if [ ! -z "$selected_shell" ]; then
            $terminal --class dotfiles-floating -e bash -c "chsh -s \$(which $selected_shell) && echo -e '\n✅ Shell berhasil diubah ke $selected_shell!\nSilakan logout dan login kembali untuk melihat perubahan.' || echo -e '\n❌ Gagal mengubah shell.'; read -n 1 -s -r -p 'Tekan tombol apa saja untuk menutup...'"
        fi
        ;;
    *Config*)
        $HOME/.config/hypr/scripts/ricing-config.sh &
        ;;
    *Screenshot*)
        $HOME/.config/hypr/scripts/screenshot.sh &
        ;;
esac

# Paksa tutup Rofi agar layar bersih
pkill -x rofi
exit 0

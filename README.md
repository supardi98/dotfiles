# 🚀 My Ultimate Dotfiles (Hyprland + Zsh Pro)

Repositori ini berisi konfigurasi pribadi (ricing) untuk lingkungan desktop **Hyprland** yang estetik dan alur kerja terminal **Zsh** yang super produktif.

## ✨ Fitur Utama
- **Hyprland**: Tampilan glassy, animasi halus, dan manajemen jendela yang efisien.
- **Zsh Pro Experience**: 
  - **Oh My Posh**: Prompt terminal yang cantik dan informatif (Tema Zen).
  - **Fastfetch**: Info sistem saat terminal dibuka.
  - **Fuzzy Search (fzf)**: Cari riwayat perintah (`Ctrl+R`) dengan sangat cepat.
  - **Smart Navigation**: `zoxide` untuk pindah folder kilat dan `Auto-CD`.
  - **Syntax Highlighting & Autosuggestions**: Hint history warna-warni ala programmer.
  - **Auto-pairing**: Otomatis menutup tanda kurung dan kutip.
- **Kitty Terminal**: Transparansi glassy, blur, dan dukungan Nerd Fonts.

## 📦 Aplikasi yang Dibutuhkan (Dependencies)

Untuk mendapatkan pengalaman penuh, silakan instal paket-paket berikut di sistem Anda (Arch/CachyOS):

```bash
sudo pacman -S hyprland hyprlock hypridle kitty waybar rofi-wayland swaync swww \
eza bat zoxide fzf lazygit yazi btop trash-cli tealdeer jq direnv nvim \
ttf-jetbrains-mono-nerd
```

## 🛠️ Cara Instalasi

1. **Clone Repositori ini:**
   ```bash
   git clone https://github.com/supardi98/dotfiles.git ~/Projects/dotfiles
   cd ~/Projects/dotfiles
   ```

2. **Jalankan Skrip Instalasi:**
   Skrip ini akan membuat tautan (symlink) dari repositori ini ke folder `~/.config/` Anda.
   ```bash
   chmod +x apply.sh
   ./apply.sh
   ```

3. **Reload Konfigurasi:**
   - Restart Hyprland (`Super + Shift + Q`).
   - Reload Zsh dengan mengetik `zsh` atau buka terminal baru.

## ⌨️ Pintasan Penting (Keybindings)

### Hyprland
- `SUPER + RETURN` : Buka Kitty Terminal
- `SUPER + SPACE`  : Buka Launcher (Rofi)
- `SUPER + Q`      : Tutup Jendela Aktif
- `SUPER + SHIFT + Q` : Keluar/Logout
- `SUPER + L`      : Kunci Layar (Hyprlock)
- `SUPER + W`      : Pilih Wallpaper

### Terminal (Zsh)
- `c` : Clear terminal.
- `lg` : Buka **Lazygit** (Git UI).
- `y` : Buka **Yazi** (File Manager).
- `btop` : Monitor Sistem.
- `h` : Cari history perintah via FZF.
- `p` : Langsung ke folder `~/Projects`.
- `extract <file>` : Ekstrak file apapun (`.zip`, `.tar.gz`, dll).
- `del <file>` : Hapus file ke tong sampah (aman).

## 📝 Catatan Khusus Programmer
Konfigurasi Zsh ini sudah mendukung:
- **LSP Support**: `EDITOR` sudah diset ke `nvim` (NeoVim).
- **Environment Auto-loader**: Mendukung `direnv` untuk isolasi proyek.
- **Web Search**: Ketik `google <kata kunci>` atau `github <repo>` langsung dari terminal.

---
Dibuat dengan ❤️ untuk produktivitas maksimal.

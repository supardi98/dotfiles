# 🚀 My Ultimate Dotfiles (Hyprland + Zsh Pro)

Repositori ini adalah koleksi konfigurasi pribadi (ricing) untuk lingkungan desktop **Hyprland** yang estetik, modern, dan sangat fungsional, dipadukan dengan alur kerja terminal **Zsh** tingkat lanjut.

## ✨ Fitur Utama
- **Hyprland Experience**:
  - **Glassy UI**: Efek blur transparan pada jendela, bar, dan launcher.
  - **Dynamic Animations**: Berbagai preset animasi (Classic, Smooth, Fast, dsb).
  - **Smart Layouts**: Manajemen jendela tiling yang cerdas.
  - **ML4W Settings**: Kontrol penuh pengaturan Hyprland melalui GUI.
- **Zsh Pro Experience**: 
  - **Oh My Posh**: Prompt terminal informatif dengan Tema Zen.
  - **Fuzzy Search (fzf)**: Cari riwayat perintah (`Ctrl+R`) secara visual.
  - **Smart Navigation**: `zoxide` (Smart CD) dan `Auto-CD`.
  - **Auto-pairing**: Otomatis menutup tanda kurung dan kutip.
  - **Programming Ready**: Integrasi `direnv`, `LSP support` via NeoVim.
- **UI & Modules**:
  - **Waybar**: Bar status kustom dengan banyak modul fungsional.
  - **SwayNC**: Pusat notifikasi yang modern.
  - **Rofi**: Launcher aplikasi, pemilih emoji, dan clipboard manager.
  - **Wlogout**: Menu logout berbasis ikon yang elegan.
  - **SDDM**: Tema Astronaut untuk layar login yang futuristik.
  - **Spicetify**: Tema ML4W untuk Spotify Anda.
  - **Awww**: Pengelola wallpaper Wayland yang cepat dan andal (sebelumnya swww).

## 📦 Aplikasi yang Dibutuhkan (Dependencies)

### 1. Paket dari Repositori Resmi (Pacman)
```bash
sudo pacman -S hyprland hyprlock hypridle kitty waybar rofi-wayland swaync \
eza bat zoxide fzf lazygit yazi btop trash-cli tealdeer jq direnv nvim \
ttf-jetbrains-mono-nerd swayosd-client playerctl wl-clipboard cliphist \
hyprpicker hyprshade rofimoji wtype
```

### 2. Paket dari AUR (Yay/Paru)
```bash
yay -S awww-bin
```

### 3. Paket dari Flatpak (ML4W Apps)
```bash
# Tambahkan repositori ML4W (jika belum ada)
flatpak remote-add --if-not-exists ml4w-repo https://ml4w.github.io/flatpak/repo/ml4w-repo.flatpakrepo

# Instal aplikasi ML4W
flatpak install ml4w-repo com.ml4w.settings com.ml4w.calendar
```

## 🛠️ Cara Instalasi

1. **Clone Repositori:**
   ```bash
   git clone https://github.com/supardi98/dotfiles.git ~/Projects/dotfiles
   cd ~/Projects/dotfiles
   ```

2. **Jalankan Instalasi Otomatis:**
   Skrip ini akan menginstal paket yang hilang dan melakukan symlink konfigurasi.
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## ⌨️ Pintasan Penting (Keybindings)

### Dasar & Aplikasi
- `SUPER + RETURN` : Buka **Kitty** Terminal
- `SUPER + SPACE`  : Buka **Launcher** (Rofi)
- `SUPER + E`      : Buka File Manager
- `SUPER + B`      : Buka Browser
- `SUPER + V`      : Riwayat **Clipboard** (Cliphist)
- `SUPER + .`      : **Pemilih Emoji** (Rofimoji)

### Jendela & Sistem
- `SUPER + Q`      : Tutup jendela aktif
- `SUPER + F`      : Fullscreen
- `SUPER + T`      : Toggle Floating
- `SUPER + L`      : **Kunci Layar** (Hyprlock)
- `SUPER + CTRL + Q` : Menu Logout (Wlogout)
- `SUPER + SHIFT + R`: Reload Hyprland Config

### Screenshot & Media
- `PRINT`          : Screenshot (Layar penuh) -> Copy
- `SHIFT + PRINT`  : Screenshot (Area) -> Copy
- `SUPER + SHIFT + H`: Toggle **Hyprshade** (Blue Light Filter)
- `SUPER + ALT + G` : Toggle **Gamemode** (Matikan animasi untuk performa)

### Navigasi Terminal (Zsh)
- `c` : Clear terminal
- `lg` : Buka **Lazygit**
- `y` : Buka **Yazi** (File Manager Terminal)
- `h` : Cari history via FZF
- `extract <file>` : Ekstrak file apapun otomatis
- `del <file>` : Hapus ke tong sampah (aman)
- `..` : Naik satu folder

---
Dibuat dengan ❤️ oleh Supardi. Gunakan dengan bijak dan selamat mengoprek!

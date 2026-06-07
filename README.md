# 🚀 My Ultimate Dotfiles (Niri + Noctalia Shell Pro)

Repositori ini adalah koleksi konfigurasi pribadi (ricing) untuk lingkungan desktop **Niri** yang estetik, modern, dan sangat fungsional, dipadukan dengan **Noctalia Shell** (Qt6/QML) dan alur kerja terminal **Zsh Pro**.

## ✨ Fitur Utama
- **Niri WM**:
  - **Scrollable Tiling**: Pengalaman tiling yang unik secara horizontal.
  - **Glassy Look**: Efek blur transparan dan animasi halus.
  - **Xwayland Satellite**: Dukungan aplikasi X11 yang terisolasi dan stabil.
- **Noctalia Shell**:
  - **Modern UI**: Panel, launcher, dan widget berbasis Qt6/QML yang sangat responsif.
  - **Integrated Selector**: Pemilih wallpaper dan skema warna langsung dari panel.
  - **Dynamic Theming**: Warna sistem otomatis menyesuaikan dengan wallpaper (via Matugen).
- **Zsh Pro Experience**: 
  - **Oh My Zsh**: Framework Zsh dengan plugin produktivitas.
  - **Zsh Plugins**: `autosuggestions`, `syntax-highlighting`, dan `fast-syntax-highlighting`.
  - **Oh My Posh**: Prompt terminal informatif dengan Tema Zen.
  - **Smart Navigation**: `zoxide` (Smart CD) dan `fzf` (Fuzzy Search).
- **System & Automation**:
  - **SilentSDDM**: Tema layar login yang elegan dengan **Sinkronisasi Wallpaper Otomatis** (SDDM akan selalu mengikuti wallpaper desktop).
  - **Clipboard History**: Manajemen riwayat clipboard via `cliphist` (Shortcut `SUPER+V`).
  - **NVM Ready**: Pengelola versi Node.js sudah terkonfigurasi otomatis di shell.

## 🛠️ Cara Instalasi (Otomatis) - REKOMENDASI

Skrip ini akan menginstal semua paket yang dibutuhkan (Pacman & AUR), mengonfigurasi Oh My Zsh, memasang tema SilentSDDM, dan melakukan symlink konfigurasi secara otomatis.

1. **Clone Repositori:**
   ```bash
   git clone https://github.com/supardi98/dotfiles.git ~/Projects/dotfiles
   cd ~/Projects/dotfiles
   ```

2. **Jalankan Skrip Instalasi:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## ⌨️ Pintasan Penting (Keybindings)

### Dasar & Aplikasi
- `SUPER + RETURN` : Buka **Kitty** Terminal
- `SUPER + SPACE`  : Buka **Launcher** / App Search
- `SUPER + E`      : Buka File Manager (Nautilus)
- `SUPER + B`      : Buka Browser (Brave)
- `SUPER + V`      : Riwayat **Clipboard**
- `SUPER + .`      : **Pemilih Emoji**

### Jendela & Sistem
- `SUPER + Q`      : Tutup jendela aktif
- `SUPER + Shift + R`: **Reload** Niri & Noctalia Shell (Sinkronisasi Tema)
- `SUPER + Shift + L`: **Kunci Layar**
- `SUPER + F`      : Maximize Kolom
- `SUPER + Shift + F`: Fullscreen Jendela
- `SUPER + C`      : Posisikan Jendela di Tengah
- `SUPER + Tab`    : Tampilan Overview (Workspaces)
- `SUPER + Wheel Mouse`: Scroll antar kolom jendela

### Navigasi Terminal (Zsh)
- `Ctrl + R` : Cari riwayat perintah secara visual (FZF).
- `Tab` : Menu pelengkap perintah yang bisa dipilih dengan panah.
- `Auto-suggestions` : Saran perintah berwarna abu-abu (Tekan Panah Kanan untuk ambil).

## 🎵 Spotify Setup
Untuk instalasi Spotify lengkap dengan Ikon Tray (Wayland) dan tema Spicetify:
```bash
chmod +x install-spotify.sh
./install-spotify.sh
```

---
Dibuat dengan ❤️ oleh **Supardi**. Gunakan dengan bijak dan selamat menikmati pengalaman Niri Pro! 🚀

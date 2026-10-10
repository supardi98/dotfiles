# 📖 Panduan Lengkap Shortcut & Fitur Desktop (Niri + Noctalia)

Dokumen ini adalah referensi lengkap seluruh fitur, alur kerja (workflow), dan kombinasi tombol (*keybindings*) pada environment **Niri Window Manager**, **Noctalia Shell v5**, dan **Kitty Terminal**.

---

## ⚡ 1. Suite Multi-Scratchpad (Persistent & Glass Blur)

Semua scratchpad bersifat **toggle** (tekan shortcut untuk memunculkan, tekan lagi untuk menyembunyikan).  
**Fitur Utama**: Jendela scratchpad tidak dimatikan saat disembunyikan, melainkan dipindahkan ke workspace tersembunyi sehingga sesi, history, dan prosesnya tetap hidup di background.

| Shortcut | Fitur & Aplikasi | Keterangan & Kemampuan |
| :--- | :--- | :--- |
| **`Super + ` `** (`~`) | **Quake Terminal** (`kitty`) | Dropdown terminal di sisi atas layar. Sesi shell (`zsh/bash`) tidak akan mati saat di-hide. |
| **`Super + G`** | **Lazygit Scratchpad** | Client Git TUI lengkap di tengah layar. Sangat cepat untuk stage, commit, dan push. |
| **`Super + N`** | **Quick Notes** (`nano`) | **Auto-save on exit**, mendukung mouse, soft-wrap, dan shortcut modern (`Ctrl+S` save, `Ctrl+Q` quit). File: `~/Notes/quicknotes.txt`. |
| **`Super + Shift + N`** | **Study Notes** (`neovim`) | **Auto-save real-time** saat mengetik, ada statusline cheat sheet (`i`, `Esc`, `u`, `Ctrl+S`), `Ctrl+S` save di semua mode. File: `~/Notes/learn-notes.md`. |
| **`Super + Shift + C`** | **Instant Calculator** (`qalc`) | Kalkulator canggih dengan **autocalc real-time** (hasil hitung langsung tampil saat rumus diketik). Mendukung konversi satuan & mata uang. |

---

## 🚀 2. Peluncur Aplikasi & Menu Cepat

| Shortcut | Aksi | Deskripsi |
| :--- | :--- | :--- |
| **`Super + Space`** | **Noctalia App Launcher** | Buka pencarian aplikasi dan riwayat penggunaan. |
| **`Super + P`** | **Global Project Switcher** | Fuzzy-finder repo git di `~/Projects` dengan preview status git. |
| **`Super + V`** | **Clipboard Manager** | Riwayat clipboard grafis Noctalia (teks dan gambar). |
| **`Super + .`** | **Emoji Picker** | Pemilih emoji grafis Noctalia. |
| **`Super + Return`** | **Terminal Utama** | Membuka jendela Kitty terminal baru. |
| **`Super + B`** | **Web Browser** | Membuka Brave Browser. |
| **`Super + E`** | **File Manager** | Membuka GNOME Nautilus. |
| **`Super + O`** | **Overview Mode** | Membuka tampilan overview kolom Niri. |
| **`Super + Shift + L`** | **Lock Screen** | Mengunci sesi layar dengan Noctalia Lockscreen. |
| **`Super + Shift + R`** | **System Reload** | Menjalankan `reload.sh` (sinkronisasi tema, warna, dan restart shell). |

---

## 🗂️ 3. Aksi Cepat pada Project Switcher (`Super + P`)

Saat menu proyek muncul, Anda dapat memilih aksi langsung menggunakan shortcut:

| Shortcut | Aksi yang Dijalankan |
| :--- | :--- |
| **`Enter`** | Membuka **Action Menu** (Pilihan: Code, Terminal, Lazygit, Nautilus, Neovim). |
| **`Ctrl + C`** | Langsung buka proyek di **VS Code**. |
| **`Ctrl + T`** | Langsung buka proyek di **Terminal Kitty**. |
| **`Ctrl + G`** | Langsung buka proyek di **Lazygit**. |
| **`Ctrl + O`** | Langsung buka direktori proyek di **Nautilus**. |
| **`Ctrl + N`** | Langsung buka proyek di **Neovim**. |

---

## 🪟 4. Manajemen Jendela & Kolom (Niri Scrollable Tiling)

### Navigasi Fokus
* **`Super + H / Left`**: Pindah fokus kolom ke kiri.
* **`Super + L / Right`**: Pindah fokus kolom ke kanan.
* **`Super + J / Down`**: Pindah fokus jendela ke bawah (dalam 1 kolom).
* **`Super + K / Up`**: Pindah fokus jendela ke atas (dalam 1 kolom).
* **`Super + Wheel Down/Up`**: Scroll horizontal antar-kolom.

### Memindahkan & Mengatur Posisi Jendela
* **`Super + Shift + H / Left`**: Geser kolom ke kiri.
* **`Super + Shift + L / Right`**: Geser kolom ke kanan.
* **`Super + Shift + J / Down`**: Pindahkan jendela ke bawah dalam kolom.
* **`Super + Shift + K / Up`**: Pindahkan jendela ke atas dalam kolom.
* **`Super + S`**: Masukkan jendela sebelah kanan ke dalam kolom aktif (*consume*).
* **`Super + Shift + S`**: Keluarkan jendela terbawah dari kolom aktif (*expel*).

### Ukuran & Mode Jendela
* **`Super + R`**: Siklus ganti lebar kolom (*preset width*: 33% $\rightarrow$ 50% $\rightarrow$ 66% $\rightarrow$ 100%).
* **`Super + Minus (-)` / `Super + Equal (=)`**: Perkecil / perbesar lebar kolom 10%.
* **`Super + Shift + Minus` / `Equal`**: Perkecil / perbesar tinggi jendela 10%.
* **`Super + C`**: Pusatkan kolom aktif ke tengah layar (*center column*).
* **`Super + F`**: Maksimalkan kolom aktif (*maximize column*).
* **`Super + Shift + F`**: Mode layar penuh (*fullscreen*).
* **`Super + T`**: Ubah antara mode Tiling dan Floating.
* **`Super + Q`**: Tutup jendela aktif (*close window*).
* **`Super + Shift + Q`**: Paksa matikan jendela (*xkill*).

---

## 🌐 5. Manajemen Workspace & Smart Auto-Routing

* **`Super + 1`**: Fokus ke Workspace **`󰅩`** (Code & Dev: VS Code, Antigravity, Terminal).
* **`Super + 2`**: Fokus ke Workspace **`󰖟`** (Web: Brave Browser, Chrome, Firefox).
* **`Super + 3`**: Fokus ke Workspace **`󰓇`** (Media & Chat: Spotify, Discord, Telegram, Slack).
* **`Super + 4`**: Fokus ke Workspace **`󰉋`** (Files & Dokumen: Nautilus, LibreOffice/WPS).
* **`Super + 5` s/d `9`**: Fokus ke Workspace numerik tambahan.
* **`Super + Shift + 1` s/d `4`**: Pindahkan kolom aktif langsung ke Workspace icon target.
* **`Super + Shift + A`**: **Toggle Auto-Routing (ON / OFF)**.
  - **ON**: Setiap aplikasi baru otomatis dibuka di workspace yang telah ditentukan.
  - **OFF**: Aplikasi dibuka bebas di workspace yang sedang aktif saat ini.
* **`Super + Tab`**: Siklus workspace berikutnya (mengabaikan workspace scratchpad tersembunyi).
* **`Super + Shift + Tab`**: Siklus workspace sebelumnya.

---

## 📸 6. Tangkapan Layar & Ekstraksi Teks (Screenshot & OCR)

* **`Print`**: Screenshot area / region interaktif.
* **`Shift + Print`**: Screenshot seluruh layar penuh (*fullscreen*).
* **`Alt + Print`**: Screenshot jendela yang sedang aktif.
* **`Super + Shift + O`**: **Instant OCR Extractor (Salin Teks dari Layar)**.
  - Memilih area di layar (gambar, video, error dialog), mengekstrak teksnya dengan Tesseract OCR, dan otomatis menyalin ke clipboard.

---

## 🔊 7. Audio, Kecerahan, Media & Daya

* **`Super + Backslash (\)`** / **`XF86AudioPlay`**: Play / Pause musik global (Spotify, Browser) + OSD toast.
* **`Super + BracketRight (])`** / **`XF86AudioNext`**: Lagu berikutnya (*Next track*).
* **`Super + BracketLeft ([)`** / **`XF86AudioPrev`**: Lagu sebelumnya (*Previous track*).
* **`XF86AudioRaiseVolume` / `LowerVolume`**: Naikkan / turunkan volume 10%.
* **`XF86AudioMute`**: Mute / unmute speaker.
* **`Super + M`**: Mute / unmute mikrofon default.
* **`XF86MonBrightnessUp` / `Down`**: Naikkan / turunkan kecerahan layar 10%.
* **`Super + Shift + I`**: **Caffeine / Presentation Mode (Toggle)**.
  - Menjaga layar tetap menyala (*anti-sleep / anti-idle*) saat presentasi atau membaca artikel panjang.

---

## 🎨 8. Fitur UI/UX & Animasi GPU

1. **GPU Spring Physics & Custom Shaders**:
   - Transisi *Overview* (`Super + O`), pergantian workspace, serta buka/tutup jendela menggunakan fisika pegas elastis (*spring dampening*) yang responsif dan sangat mulus (*butter-smooth*).
2. **Frosted Glass Blur**:
   - Aktif pada panel Noctalia, Notification Toasts, OSD Volume/Brightness, Kitty Terminal, Quake Terminal, dan seluruh Scratchpad.
3. **Indikator Sysmon Bar**:
   - **CPU**: Speedometer gauge (`brand-speedtest`).
   - **RAM**: Microchip icon (`cpu`).
   - **Disk**: Database cylinder icon (`database`).
4. **Pipelining Warna Otomatis**:
   - Ganti wallpaper lewat Noctalia akan meng-update palet warna Material You (Matugen), tema GTK, Kitty, Niri dynamic border, dan btop secara sinkron.

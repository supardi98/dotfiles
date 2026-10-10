#!/usr/bin/env bash
# ☕ Caffeine / Presentation Mode Toggle (Super + Shift + I)
# Prevents idle sleep and screen locking using systemd-inhibit

PID_FILE="/tmp/niri_caffeine.pid"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    # Sedang aktif -> Matikan
    CAFFEINE_PID=$(cat "$PID_FILE")
    kill "$CAFFEINE_PID" 2>/dev/null
    rm -f "$PID_FILE"
    notify-send -u low -i preferences-desktop-screensaver -t 2500 "Caffeine: OFF 💤" "Layar akan tidur/redup normal sesuai pengaturan idle."
else
    # Sedang nonaktif -> Aktifkan
    systemd-inhibit --what=idle:sleep:handle-lid-switch --who="Niri Caffeine" --why="User requested presentation mode" sleep infinity &
    echo $! > "$PID_FILE"
    notify-send -u normal -i coffee -t 3000 "Caffeine: ON ☕" "Mode Presentasi Aktif. Layar tidak akan tidur atau redup."
fi

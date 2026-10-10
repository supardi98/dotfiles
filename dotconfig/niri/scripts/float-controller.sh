#!/usr/bin/env bash
# 🪟 Dedicated Window Floating / Tiling Controller
# Usage:
#   float-controller.sh float-active   -> Jadikan jendela aktif Floating
#   float-controller.sh tile-active    -> Jadikan jendela aktif Tiling
#   float-controller.sh float-all      -> Jadikan semua jendela di workspace Floating
#   float-controller.sh tile-all       -> Jadikan semua jendela di workspace Tiling

ACTION="$1"

python3 - "$ACTION" << 'PYEOF'
import subprocess
import json
import sys

action = sys.argv[1] if len(sys.argv) > 1 else ""

try:
    windows = json.loads(subprocess.check_output(['niri', 'msg', '-j', 'windows']))
    workspaces = json.loads(subprocess.check_output(['niri', 'msg', '-j', 'workspaces']))
except Exception as e:
    sys.exit(0)

focused_ws = next((w for w in workspaces if w.get('is_focused')), None)
if not focused_ws:
    sys.exit(0)

ws_id = focused_ws['id']
ws_windows = [
    w for w in windows 
    if w.get('workspace_id') == ws_id 
    and w.get('app_id') not in ['quake', 'scratch-notes', 'scratch-calc', 'scratch-nvim', 'scratch-lazygit', 'project-switcher']
]

if not ws_windows:
    sys.exit(0)

focused_win = next((w for w in ws_windows if w.get('is_focused')), ws_windows[0])

if action == "float-active":
    if not focused_win.get('is_floating'):
        subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
elif action == "tile-active":
    if focused_win.get('is_floating'):
        subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
elif action == "float-all":
    curr_id = focused_win['id']
    for win in ws_windows:
        if not win.get('is_floating'):
            subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(win['id'])], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(curr_id)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['notify-send', '-u', 'low', '-i', 'view-restore', '-t', '1500', 
                    "Workspace", f"Semua jendela ({len(ws_windows)}) dialihkan ke Floating 🪟"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
elif action == "tile-all":
    curr_id = focused_win['id']
    for win in ws_windows:
        if win.get('is_floating'):
            subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(win['id'])], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(curr_id)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['notify-send', '-u', 'low', '-i', 'view-grid', '-t', '1500', 
                    "Workspace", f"Semua jendela ({len(ws_windows)}) dialihkan ke Tiling 📐"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

PYEOF

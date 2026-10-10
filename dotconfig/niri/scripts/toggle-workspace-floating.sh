#!/usr/bin/env bash
# 🔄 Toggle Floating / Tiling for all windows in the current workspace (Super + Shift + T)

python3 - << 'PYEOF'
import subprocess
import json
import sys

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

# Save currently focused window id
current_focused_id = next((w['id'] for w in ws_windows if w.get('is_focused')), ws_windows[0]['id'])

# Count floating vs tiled
floating_count = sum(1 for w in ws_windows if w.get('is_floating'))
total_count = len(ws_windows)

# If ALL are floating -> tile all. Otherwise (some or all are tiled) -> float all.
if floating_count == total_count:
    target_action = "tile"
else:
    target_action = "float"

for win in ws_windows:
    is_fl = win.get('is_floating', False)
    wid = win['id']
    if target_action == "float" and not is_fl:
        subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(wid)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    elif target_action == "tile" and is_fl:
        subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(wid)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(['niri', 'msg', 'action', 'toggle-window-floating'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Restore focus back to original window
subprocess.run(['niri', 'msg', 'action', 'focus-window', '--id', str(current_focused_id)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

# Send user notification
ws_name = focused_ws.get('name') or str(focused_ws.get('idx', 'Current'))
if target_action == "float":
    subprocess.run(['notify-send', '-u', 'low', '-i', 'view-restore', '-t', '1500', 
                    f"Workspace {ws_name}", f"Semua jendela ({len(ws_windows)}) dialihkan ke Floating 🪟"])
else:
    subprocess.run(['notify-send', '-u', 'low', '-i', 'view-grid', '-t', '1500', 
                    f"Workspace {ws_name}", f"Semua jendela ({len(ws_windows)}) dialihkan ke Tiling 📐"])

PYEOF

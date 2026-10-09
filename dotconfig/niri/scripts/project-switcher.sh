#!/usr/bin/env bash
# 🚀 Global Project Switcher (Niri + Kitty + fzf)
# Fast fuzzy-jump to any programming project with Git status & tree preview

PROJECTS_DIR="$HOME/Projects"

if [ ! -d "$PROJECTS_DIR" ]; then
    notify-send "Project Switcher" "Folder $PROJECTS_DIR tidak ditemukan."
    exit 1
fi

# Function to list project directories (git repos & direct subfolders)
get_projects() {
    python3 -c "
import os
projects_dir = os.path.expanduser('$PROJECTS_DIR')
found = set()

# Find all git repositories
for root, dirs, files in os.walk(projects_dir):
    if '.git' in dirs:
        rel = os.path.relpath(root, projects_dir)
        found.add((rel, root))
        dirs.clear()

# Add direct subdirectories in ~/Projects if not already included
for item in os.listdir(projects_dir):
    full = os.path.join(projects_dir, item)
    if os.path.isdir(full) and not item.startswith('.'):
        rel = item
        if not any(r == rel or r.startswith(rel + '/') for r, _ in found):
            found.add((rel, full))

for rel, path in sorted(found, key=lambda x: x[0].lower()):
    print(f'{rel}\t{path}')
"
}

# Run fzf selector with preview and multi-action keybindings
SELECTED=$(get_projects | fzf \
    --delimiter=$'\t' \
    --with-nth=1 \
    --ansi \
    --prompt="🚀 Pilih Project > " \
    --header="[ENTER] Pilih Aksi  |  [Ctrl+C] VS Code  |  [Ctrl+T] Terminal  |  [Ctrl+G] Lazygit  |  [Ctrl+O] Files" \
    --header-first \
    --color="bg:-1,bg+:-1,preview-bg:-1" \
    --border=rounded \
    --margin=1 \
    --padding=1 \
    --preview-window="right:55%:wrap" \
    --preview="bash $HOME/.config/niri/scripts/project-preview.sh {2}" \
    --expect=ctrl-c,ctrl-t,ctrl-g,ctrl-o,ctrl-n)

# Check if user made a selection
KEY=$(echo "$SELECTED" | head -n 1)
LINE=$(echo "$SELECTED" | sed -n '2p')

if [ -z "$LINE" ]; then
    exit 0
fi

PROJECT_NAME=$(echo "$LINE" | cut -f1)
TARGET_PATH=$(echo "$LINE" | cut -f2)

if [ ! -d "$TARGET_PATH" ]; then
    exit 0
fi

# Function to launch the selected application in a detached session
launch_app() {
    local choice="$1"
    case "$choice" in
        *VS\ Code*|vscode|code|1)
            setsid -f code "$TARGET_PATH" >/dev/null 2>&1
            ;;
        *Terminal*|terminal|kitty|2)
            setsid -f kitty --directory "$TARGET_PATH" >/dev/null 2>&1
            ;;
        *Lazygit*|lazygit|git|3)
            setsid -f kitty --directory "$TARGET_PATH" lazygit >/dev/null 2>&1
            ;;
        *File*|nautilus|files|4)
            setsid -f nautilus "$TARGET_PATH" >/dev/null 2>&1
            ;;
        *Neovim*|neovim|nvim|5)
            setsid -f kitty --directory "$TARGET_PATH" nvim . >/dev/null 2>&1
            ;;
    esac
}

# If user pressed a direct shortcut, launch immediately
case "$KEY" in
    ctrl-c)
        launch_app "1"
        exit 0
        ;;
    ctrl-t)
        launch_app "2"
        exit 0
        ;;
    ctrl-g)
        launch_app "3"
        exit 0
        ;;
    ctrl-o)
        launch_app "4"
        exit 0
        ;;
    ctrl-n)
        launch_app "5"
        exit 0
        ;;
esac

# If user pressed ENTER, show the Action Picker menu
ACTION_MENU=$(cat << 'EOF'
1. 💻 VS Code (code)
2. 📟 Terminal (kitty)
3. 🌿 Lazygit (git client)
4. 📁 File Manager (nautilus)
5. 📝 Neovim (terminal editor)
EOF
)

CHOSEN_ACTION=$(echo "$ACTION_MENU" | fzf \
    --prompt="⚡ Buka [$PROJECT_NAME] dengan > " \
    --color="bg:-1,bg+:-1,preview-bg:-1" \
    --border=rounded \
    --margin=1 \
    --padding=1 \
    --header="Ketik angka 1-5 atau gunakan panah & tekan ENTER" \
    --header-first)

if [ -n "$CHOSEN_ACTION" ]; then
    launch_app "$CHOSEN_ACTION"
fi

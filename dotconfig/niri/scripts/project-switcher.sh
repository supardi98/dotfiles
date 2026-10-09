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
    --prompt="🚀 Jump to Project > " \
    --header="[ENTER] Code  |  [Ctrl+T] Terminal  |  [Ctrl+G] Lazygit  |  [Ctrl+O] Files" \
    --header-first \
    --border=rounded \
    --margin=1 \
    --padding=1 \
    --preview-window="right:55%:wrap" \
    --preview="bash $HOME/.config/niri/scripts/project-preview.sh {2}" \
    --expect=ctrl-t,ctrl-g,ctrl-o)

# Check if user made a selection
KEY=$(echo "$SELECTED" | head -n 1)
LINE=$(echo "$SELECTED" | sed -n '2p')

if [ -z "$LINE" ]; then
    exit 0
fi

TARGET_PATH=$(echo "$LINE" | cut -f2)

if [ ! -d "$TARGET_PATH" ]; then
    exit 0
fi

case "$KEY" in
    ctrl-t)
        kitty --directory "$TARGET_PATH" &
        ;;
    ctrl-g)
        kitty --directory "$TARGET_PATH" lazygit &
        ;;
    ctrl-o)
        nautilus "$TARGET_PATH" &
        ;;
    *)
        code "$TARGET_PATH" &
        ;;
esac

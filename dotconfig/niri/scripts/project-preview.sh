#!/usr/bin/env bash
# Helper preview script for Project Switcher
TARGET="$1"

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
    echo "Folder tidak ditemukan."
    exit 0
fi

echo -e "\033[1;36m📂 Path: $TARGET\033[0m\n"

echo -e "\033[1;34m📁 Directory Structure:\033[0m"
if command -v eza >/dev/null 2>&1; then
    eza -T -L 2 --icons --color=always "$TARGET" 2>/dev/null | head -n 25
else
    ls -la "$TARGET" | head -n 25
fi

echo ""
if [ -d "$TARGET/.git" ]; then
    echo -e "\033[1;32m🌿 Git Status:\033[0m"
    STATUS=$(git -C "$TARGET" status -s 2>/dev/null)
    if [ -n "$STATUS" ]; then
        echo "$STATUS" | head -n 10
    else
        echo -e "\033[0;32m(working tree clean)\033[0m"
    fi
    
    echo ""
    echo -e "\033[1;33m📜 Recent Commits:\033[0m"
    git -C "$TARGET" log --oneline --color=always -n 5 2>/dev/null
fi

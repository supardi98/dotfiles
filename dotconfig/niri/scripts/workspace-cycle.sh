#!/usr/bin/env bash
# 🔄 Niri Workspace Cycling Script

ACTION=$1 # "next" atau "prev"

# Ambil daftar workspace dan cari yang sedang fokus
WS_DATA=$(niri msg -j workspaces)
CURRENT_IDX=$(echo "$WS_DATA" | jq -r '.[] | select(.is_focused) | .idx')
ALL_IDXS=($(echo "$WS_DATA" | jq -r '.[] | .idx' | sort -n))
COUNT=${#ALL_IDXS[@]}

# Cari posisi index saat ini di dalam array
for i in "${!ALL_IDXS[@]}"; do
   if [[ "${ALL_IDXS[$i]}" = "${CURRENT_IDX}" ]]; then
       POS=$i
       break
   fi
done

if [ "$ACTION" == "next" ]; then
    NEW_POS=$(( (POS + 1) % COUNT ))
else
    NEW_POS=$(( (POS - 1 + COUNT) % COUNT ))
fi

TARGET_IDX=${ALL_IDXS[$NEW_POS]}

# Pindah ke workspace target
niri msg action focus-workspace "$TARGET_IDX"

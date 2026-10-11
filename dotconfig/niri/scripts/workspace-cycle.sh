#!/usr/bin/env bash
# 🔄 Niri Workspace Cycling Script (Active/Occupied Only)
# Cycles only through workspaces that have active windows, skipping empty workspaces and scratchpad.

ACTION="${1:-next}" # "next" atau "prev"

# Ambil data workspace dan jendela dari Niri
WS_DATA=$(niri msg -j workspaces 2>/dev/null)
WIN_DATA=$(niri msg -j windows 2>/dev/null)

[ -z "$WS_DATA" ] || [ -z "$WIN_DATA" ] && exit 0

CURRENT_IDX=$(echo "$WS_DATA" | jq -r '.[] | select(.is_focused) | .idx // empty')

# Ambil list index workspace yang aktif terisi jendela aplikasi (bukan scratchpad)
ACTIVE_IDXS=($(echo "$WS_DATA" | jq -r --argjson ids "$(echo "$WIN_DATA" | jq '[.[].workspace_id // empty] | unique')" '.[] | select((.id as $wid | $ids | index($wid)) and .name != "scratchpad") | .idx' | sort -n))
COUNT=${#ACTIVE_IDXS[@]}

# Jika tidak ada workspace yang terisi atau hanya ada 1 workspace aktif, tidak perlu pindah
if [ "$COUNT" -le 1 ]; then
    exit 0
fi

# Cari posisi index saat ini di dalam array workspace aktif
POS=-1
for i in "${!ACTIVE_IDXS[@]}"; do
    if [[ "${ACTIVE_IDXS[$i]}" = "$CURRENT_IDX" ]]; then
        POS=$i
        break
    fi
done

if [ "$POS" -ge 0 ]; then
    if [ "$ACTION" == "next" ]; then
        NEW_POS=$(( (POS + 1) % COUNT ))
    else
        NEW_POS=$(( (POS - 1 + COUNT) % COUNT ))
    fi
else
    # Jika posisi saat ini berada di workspace kosong, cari workspace terisi terdekat
    if [ "$ACTION" == "next" ]; then
        NEW_POS=0
        for i in "${!ACTIVE_IDXS[@]}"; do
            if [ "${ACTIVE_IDXS[$i]}" -gt "$CURRENT_IDX" ]; then
                NEW_POS=$i
                break
            fi
        done
    else
        NEW_POS=$(( COUNT - 1 ))
        for (( i=COUNT-1; i>=0; i-- )); do
            if [ "${ACTIVE_IDXS[$i]}" -lt "$CURRENT_IDX" ]; then
                NEW_POS=$i
                break
            fi
        done
    fi
fi

TARGET_IDX=${ACTIVE_IDXS[$NEW_POS]}

# Pindah ke workspace target
if [ -n "$TARGET_IDX" ] && [ "$TARGET_IDX" != "$CURRENT_IDX" ]; then
    niri msg action focus-workspace "$TARGET_IDX"
fi

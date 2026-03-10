#!/usr/bin/env bash

# Project Ricing: Advanced Glassy Volume Menu (Rofi-based)

# Load theme path
THEME="/home/supardi/Projects/ricing/conf/rofi/glassy-list.rasi"

# --- VOLUME & MUTE STATUS ---
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100 "%"}')
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c "MUTED")

if [ "$is_muted" -eq 1 ]; then
    mute_toggle="󰝟  Unmute Output (Currently Muted)"
else
    mute_toggle="󰕾  Mute Output (Current: $volume)"
fi

# --- MIC STATUS ---
mic_volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2 * 100 "%"}')
mic_muted=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c "MUTED")

if [ "$mic_muted" -eq 1 ]; then
    mic_toggle="󰍭  Unmute Mic (Currently Muted)"
else
    mic_toggle="󰍬  Mute Mic (Current: $mic_volume)"
fi

# --- GET OUTPUT DEVICES (SINKS) ---
# Extracting lines under "Sinks:" until the next header
mapfile -t output_devices < <(wpctl status | sed -n '/Sinks:/,/Sources:/p' | grep -E "^\s+[0-9]+\." | \
    sed -E 's/^[[:space:]]+//' | sed -E 's/\*/󰄬 /' | sed -E 's/^([0-9]+)/  \1/' | sed 's/\[vol.*//')

# --- GET INPUT DEVICES (SOURCES) ---
# Extracting lines under "Sources:" until "Filters:" or end
mapfile -t input_devices < <(wpctl status | sed -n '/Sources:/,/Filters:/p' | grep -E "^\s+[0-9]+\." | \
    sed -E 's/^[[:space:]]+//' | sed -E 's/\*/󰄬 /' | sed -E 's/^([0-9]+)/  \1/' | sed 's/\[vol.*//')

# --- PREPARE ROFI INPUT ---
rofi_input="--- CONTROLS ---\n$mute_toggle\n$mic_toggle\n\n--- OUTPUT DEVICES ---\n$(printf "%s\n" "${output_devices[@]}")\n\n--- INPUT DEVICES ---\n$(printf "%s\n" "${input_devices[@]}")\n\n󰓃  Open Full Mixer"

# Show Rofi menu
selection=$(echo -e "$rofi_input" | rofi -dmenu -config "$THEME" -i -p "Audio Menu")

# --- HANDLE SELECTION ---
if [ -z "$selection" ]; then
    exit
elif [[ "$selection" == *"Unmute Output"* ]] || [[ "$selection" == *"Mute Output"* ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
elif [[ "$selection" == *"Unmute Mic"* ]] || [[ "$selection" == *"Mute Mic"* ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
elif [[ "$selection" == *"Open Full Mixer"* ]]; then
    pavucontrol &
elif [[ "$selection" == *"󰄬"* ]] || [[ "$selection" == "---"* ]]; then
    exit
else
    # Extract ID and set as default
    id=$(echo "$selection" | grep -oE "[0-9]+" | head -n 1)
    if [ -n "$id" ]; then
        wpctl set-default "$id"
        # Check if it's an input or output to send correct notification
        if [[ "$selection" == *"Input"* ]]; then
             notify-send "Audio" "Input switched"
        else
             notify-send "Audio" "Output switched"
        fi
    fi
fi

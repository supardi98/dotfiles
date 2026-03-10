#!/usr/bin/env bash

# Project Ricing: WiFi Menu with Rescan Fix

THEME="/home/supardi/Projects/ricing/conf/rofi/glassy-list.rasi"

# Perform actual scan if requested
if [ "$1" == "rescan" ]; then
    notify-send "WiFi" "Scanning for new networks..." -i network-wireless
    nmcli device wifi rescan
    sleep 2
fi

# Robust WiFi listing
# We use -t (terse) for stable parsing: SSID:SIGNAL:BARS:SECURITY:ACTIVE
mapfile -t options < <(nmcli -t -f "SSID,SIGNAL,BARS,SECURITY,ACTIVE" device wifi list | \
    awk -F: '{ 
        if ($1 != "" && $1 != "--") {
            mark = ($5 == "yes") ? "󰄬" : " "
            printf "%s %s %s (%s%%)\n", mark, $3, $1, $2
        }
    }' | sort -u -t' ' -k3)

# WiFi status toggle
wifi_status=$(nmcli -fields WIFI g)
if [[ "$wifi_status" =~ "enabled" ]]; then
    toggle="󰖪  Turn Off WiFi"
else
    toggle="󰖩  Turn On WiFi"
fi

# Prepare Rofi input
rofi_input="$toggle\n󰑐  Rescan Networks\n$(printf "%s\n" "${options[@]}")\n󰇄  Open Network Manager"

# Show Rofi menu
selection=$(echo -e "$rofi_input" | rofi -dmenu -config "$THEME" -i -p "WiFi Menu")

# Handle selection
if [ -z "$selection" ]; then
    exit
elif [[ "$selection" == *"Rescan Networks"* ]]; then
    exec "$0" "rescan"
elif [[ "$selection" == *"Turn Off WiFi"* ]]; then
    nmcli radio wifi off
elif [[ "$selection" == *"Turn On WiFi"* ]]; then
    nmcli radio wifi on
elif [[ "$selection" == *"Open Network Manager"* ]]; then
    nm-connection-editor &
elif [[ "$selection" == *"󰄬"* ]]; then
    ssid=$(echo "$selection" | awk '{for(i=3;i<NF;i++) printf $i" "; print ""}' | sed 's/ $//')
    notify-send "WiFi" "Already connected to $ssid"
else
    # Extract SSID (everything between bars icon and signal parenthesis)
    ssid=$(echo "$selection" | awk '{for(i=3;i<NF;i++) printf $i" "; print ""}' | sed 's/ $//')
    notify-send "WiFi" "Connecting to $ssid..."
    if nmcli device wifi connect "$ssid"; then
        notify-send "WiFi" "Successfully connected to $ssid"
    else
        notify-send "WiFi" "Failed to connect to $ssid"
    fi
fi

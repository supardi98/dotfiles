#!/usr/bin/env bash

# Check if playerctl is running
if ! playerctl status &> /dev/null; then
    exit 0
fi

# Get metadata
artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
status=$(playerctl status)

# Set icon based on status
if [ "$status" = "Playing" ]; then
    icon=""
else
    icon="󰏤"
fi

# Limit title/artist length
max_length=25
display_text="$artist - $title"

if [ ${#display_text} -gt $max_length ]; then
    display_text="${display_text:0:$max_length}..."
fi

echo "{\"text\": \"$icon $display_text\", \"tooltip\": \"$artist - $title\", \"class\": \"$status\"}"

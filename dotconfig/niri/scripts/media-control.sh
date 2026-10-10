#!/usr/bin/env bash
# 🎵 Media Controller with OSD Feedback
# Usage: media-control.sh {play-pause|next|prev}

ACTION=$1

case "$ACTION" in
    play-pause)
        playerctl play-pause 2>/dev/null || noctalia msg media play-pause 2>/dev/null
        ;;
    next)
        playerctl next 2>/dev/null || noctalia msg media next 2>/dev/null
        ;;
    prev)
        playerctl previous 2>/dev/null || noctalia msg media previous 2>/dev/null
        ;;
    *)
        echo "Usage: $0 {play-pause|next|prev}"
        exit 1
        ;;
esac

# Berikan jeda sejenak untuk pembacaan metadata lagu
sleep 0.15

STATUS=$(playerctl status 2>/dev/null || echo "")
if [ -n "$STATUS" ]; then
    TITLE=$(playerctl metadata title 2>/dev/null || echo "Unknown Track")
    ARTIST=$(playerctl metadata artist 2>/dev/null || echo "Unknown Artist")
    
    if [ "$STATUS" = "Playing" ]; then
        ICON="media-playback-start"
        HEADER="Now Playing ▶"
    else
        ICON="media-playback-pause"
        HEADER="Paused ⏸"
    fi
    
    notify-send -u low -i "$ICON" -t 2000 "$HEADER" "$TITLE\n$ARTIST"
fi

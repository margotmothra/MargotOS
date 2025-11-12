#!/usr/bin/env bash

# Get PipeWire/PulseAudio volume info
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED" && echo "yes" || echo "no")

# Set icon based on volume and mute status
if [ "$MUTED" = "yes" ]; then
    ICON="volume-xmark"
elif [ "$VOLUME" -eq 0 ]; then
    ICON="volume-off"
elif [ "$VOLUME" -lt 30 ]; then
    ICON="volume-low"
else
    ICON="volume-high"
fi

# Output waybar format with SVG path
echo "{\"text\": \"${VOLUME}%\", \"tooltip\": \"Volume: ${VOLUME}%\", \"class\": \"${ICON}\"}"
#!/usr/bin/env bash

# Get notification status from swaync
NOTIF_DATA=$(swaync-client -swb 2>/dev/null)

if [ $? -ne 0 ]; then
    # Fallback if swaync not available
    echo "{\"text\": \"\", \"class\": \"none\"}"
    exit 0
fi

# Parse the notification data
COUNT=$(echo "$NOTIF_DATA" | jq -r '.text // "0"')
CLASS=$(echo "$NOTIF_DATA" | jq -r '.class // "none"')

# Set icon based on notification state
case "$CLASS" in
    "notification"|"dnd-notification"|"inhibited-notification"|"dnd-inhibited-notification")
        ICON="bell"
        ;;
    *)
        ICON="bell"
        ;;
esac

echo "{\"text\": \"$COUNT\", \"class\": \"$ICON\"}"
#!/bin/bash

# Screenshot name
FILE="$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

MESSAGE="Screenshot saved"

# Parse argument
MODE="$1"

case "$MODE" in
    --fullscreen)
        grim "$FILE"
	;;
    --region)
	grim -g "$(slurp)" "$FILE"
	;;
    --clipboard)
        grim - | wl-copy
	MESSAGE="📋 Screenshot copied to clipboard"
	;;
    --region-clipboard)
        grim -g "$(slurp)" - | wl-copy
	MESSAGE="📋 Area copied to clipboard"
	;;
    --edit)
        grim -g "$(slurp)" - | swappy -f -
	;;
    *)
    echo "Usage: $0 [--fullscreen|--region|--clipboard|--region-clipboard|--edit"
    exit 1
    ;;
esac

# Send notification with icon with action
notify-send "$MESSAGE" -i "$FILE" -h string:x-canonical-private-synchronous:screenshot -u low
    

#!/bin/bash

iDIR="$HOME/.config/swaync/icons"

get_backlight() {
    brightnessctl -m | cut -d, -f4 | sed 's/%//'
}

get_icon() {
    level=$(get_backlight)
	if   [ "$level" -le "20" ]; then
	    icon="$iDIR/brightness-20.png"
	elif [ "$level" -le "40" ]; then
	    icon="$iDIR/brightness-40.png"
	elif [ "$level" -le "60" ]; then
	    icon="$iDIR/brightness-60.png"
	elif [ "$level" -le "80" ]; then
	    icon="$iDIR/brightness-80.png"
	else
	    icon="$iDIR/brightness-100.png"
	fi
}

get_icon

notify-send -e -a "brightness notify" -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$level -u low -i $icon "Screen" "Brightness:$level%"

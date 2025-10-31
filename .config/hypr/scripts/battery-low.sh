#!/bin/bash

# Get battery percentage
battery_path=$(upower -e | grep BAT)
battery_level=$(upower -i "$battery_path" | awk '/percentage/ {gsub("%",""); print $2}')

# Get charging state
charging=$(upower -i "$battery_path" | awk '/state/ {print $2}')

# Notify if under 20% and not charging
if [[ "$battery_level" -le 20 && "$charging" != "charging" ]]; then
    notify-send -u critical \
	    -i "${HOME}/.config/swaync/icons/battery-quarter-solid.svg" \
	    "Battery Low" "Battery level is ${battery_level}%"
fi

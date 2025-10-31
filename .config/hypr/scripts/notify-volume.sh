#!/bin/bash

iDIR="$HOME/.config/swaync/icons"

get_volume() {
    volume=$(pamixer --get-volume)
    isMuted=$(pamixer --get-mute)
    if [ "$volume" -eq "0" ] || [ "$isMuted" = "true" ]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

get_icon() {
    current=$(get_volume)
    if [[ "$current" == "Muted" ]]; then
        echo "$iDIR/volume-mute.png"
    elif [[ "${current%\%}" -le 30 ]]; then
        echo "$iDIR/volume-low.png"
    elif [[ "${current%\%}" -le 60 ]]; then
        echo "$iDIR/volume-mid.png"
    else
        echo "$iDIR/volume-high.png"
    fi
}

notify_volume() {
    if [[ "$(get_volume)" == "Muted" ]]; then
        notify-send -e -a "volume notify" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume:" " Muted"
    else
        notify-send -e -a "volume notify" -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" " Volume Level:" " $(get_volume)"
    fi
}

notify_mic() {
    volume=$(pamixer --default-source --get-volume)
    isMuted=$(pamixer --default-source --get-mute)
    if [ "$isMuted" = "true" ] || [ "$volume" -eq 0]; then
        icon="$iDIR/microphone-mute.png"
        notify-send -e -a "volume notify" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$icon" " Microphone Muted"
    else
        icon="$iDIR/microphone.png"
        notify-send -e -a "volume notify" -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -u low -i "$icon" " Microphone Level: $volume"
    fi
}

if [[ "$1" == "--volume" ]]; then
	notify_volume
elif [[ "$1" == "--mic" ]]; then
	notify_mic
else
    echo "Usage: $0 [--volume|--mic]"
    exit 1
fi

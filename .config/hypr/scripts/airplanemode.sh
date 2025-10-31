#!/bin/bash
status=$(nmcli radio wifi)
if [ "$status" = "enabled" ]; then
    nmcli radio all off
    notify-send "✈️ Airplane mode" "Disabled all radios"
else
    nmcli radio all on
    notify-send "📡 Airplane mode" "Re-enabled all radios"
fi

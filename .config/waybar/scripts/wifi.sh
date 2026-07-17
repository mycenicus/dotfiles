#!/bin/bash
# Show available options
connections=$(nmcli -f "NAME,TYPE" connection show | grep wifi | cut -d" " -f1 | sed "s/^/  /")
wifi=$(nmcli --terse --fields SSID,BARS,SIGNAL device wifi list | sed "/^:/d; s/:/ | /g")

# Read selection
choice=$(echo -e "${connections}\n${wifi}" | rofi -dmenu -p "WIFI")
[ -z "$choice" ] && exit 0

# Try connecting.
case "$choice" in
    "  "*)
        # Existing connection
        connection="${choice#  }"
        nmcli connection up "$connection"
        ;;
    *)
      ssid="${choice%% | *}"

      password=$(rofi -dmenu -password -mesg "Enter the password in above field")

      # If the password is empty, nmcli will attempt an open network.
      if [ -n "$password" ]; then
          nmcli device wifi connect "$ssid" password "$password"
      else
          nmcli device wifi connect "$ssid"
      fi
      ;;
esac

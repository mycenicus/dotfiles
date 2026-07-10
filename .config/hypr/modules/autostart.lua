-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("waybar & hyprpaper & hypridle & swaync")
   hl.exec_cmd("systemctl --user start hyprpolkitagent")
   hl.exec_cmd("blueman-applet")
   hl.exec_cmd("wl-paste --type text --watch cliphist store")
   hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

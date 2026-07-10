local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "firefox"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("[float; size 800 550]" .. terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("swaync-client -t"))
-- TODO: Resize so it's 55% x 65% y
hl.bind(mainMod .. " + SPACE", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    --hl.dispatch(hl.dsp.window.resize({}))
    hl.dispatch(hl.dsp.window.center())
end)
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({}))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
-- TODO: Can this script be put in a function?
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")) -- hide waybar
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + S", hl.dsp.window.resize())
-- TODO: Can this script be put in a function?
-- suppressMaximizeRule:set_enabled(false)
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("~/.config/hypr/scripts/noanim.sh"))

-- TODO: Can all these scripts be put in a single function?
-- PrintScreen = fullscreen screenshot
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --fullscreen"))
-- Shift+PrintScreen = select area
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --region"))
-- 📋 Ctrl+PrintScreen = copy fullscreen to clipboard
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --clipboard"))
-- 📋 Ctrl+Shift+PrintScreen = copy area to clipboard
hl.bind("CTRL +SHIFT", hl.dsp.exec_cmd("exec, ~/.config/hypr/scripts/screenshot.sh --region-clipboard"))
-- SUPER+PrintScreen = edit area screenshot in swappy
hl.bind("SUPER + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --edit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "down" }))

-- TODO: Resize windows
-- hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({x=x+50,y=0}))
-- hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ direction = "right" }))
-- hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ direction = "up" }))
-- hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- TODO: Can all these scripts be put in a single function?
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5 && ~/.config/hypr/scripts/notify-volume.sh --volume"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5 && ~/.config/hypr/scripts/notify-volume.sh --volume"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t && ~/.config/hypr/scripts/notify-volume.sh --volume"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pamixer --default-source -t && ~/.config/hypr/scripts/notify-volume.sh --volume"),   { locked = true, repeating = true })

-- -n3886 = minimal value is 6%
-- you can check yours by brightnessctl set 6%
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n3886 set 5%+&& ~/.config/hypr/scripts/notify-brightness.sh"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n3886 set 5%- && ~/.config/hypr/scripts/notify-brightness.sh"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

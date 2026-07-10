-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
--------------
---- TAGS ----
--------------

hl.window_rule({
   tag = "+multimedia_video",
   match = { class = "^([Mm]pv|vlc)$"},
   no_blur = true,
   float = true,
   size = {"(monitor_w*0.5)", "(monitor_h*0.6)"}
})
hl.window_rule({
   tag = "+settings",
   match = { class = "^(nm-applet|nm-connection-editor|blueman-manager|org.gnome.FileRoller|nwg-look)$"},
   no_blur = true,
})
hl.window_rule({
   tag = "+settings",
   match = { class = "^(org.gnome.DiskUtility|wihotspot(-gui)?)$"},
})
hl.window_rule({
   tag = "+viewer",
   match = { class = "^(org.gnome.SystemMonitor|org.gnome.Evince|eog|org.gnome.Loupe)$"},
   float = true,
})

-----------------
---- WINDOWS ----
-----------------
hl.window_rule({
   match = { class = "^(org.pulseaudio.pavucontrol|org.gnome.Nautilus)$" },
   float = true,
   size = {"(monitor_w*0.5)", "(monitor_h*0.6)"},
})
hl.window_rule({
   match = { title = "^(Save As|Save a File|Pick Files)$" },
   float = true,
   size = {"(monitor_w*0.5)", "(monitor_h*0.6)"},
   center = true,
})
hl.window_rule({
   match = { initial_title = "^(Open Files)$" },
   float = true,
   size = {"(monitor_w*0.7)", "(monitor_h*0.6)"},
   center = true,
})

---------------------
---- LAYER RULES ----
---------------------
hl.layer_rule({
   match = { namespace = "swaync-control-center" },
   animation = "slide right",
   ignore_alpha = 0.5,
   xray = false,
})
hl.layer_rule({
   match = { namespace = "swaync-notification-window" },
   animation = "slide right",
   ignore_alpha = 0.5,
   xray = false,
})
hl.layer_rule({
   match = { namespace = "waybar" },
   ignore_alpha = 0.5,
})

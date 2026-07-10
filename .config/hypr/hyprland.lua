-- Even though I prefer to keep everything in a single file, this is required
-- because if it was all in a single module, if there was an error whole
-- hyprland would crash
-- TODO: grep -nr 'TODO:' *
require("modules.monitors")
require("modules.autostart")
require("modules.env")
require("modules.decorations")
require("modules.layout")
require("modules.misc")
require("modules.input")
require("modules.binds")
require("modules.windowrules")

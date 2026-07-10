local matugen = require("colors")
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 3,

        border_size = 2,

        col = {
            active_border   = { colors = { matugen.primary, matugen.tertiary } },
            inactive_border = matugen.outline_variant,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
    },

    decoration = {
        rounding       = 10,
        rounding_power = 7,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = 0xee0a0a0a,
        },

        blur = {
            enabled   = true,
            size      = 5,
            passes    = 3,
            vibrancy  = 0.1696,
            ignore_opacity = true,
            new_optimizations = true,
            special = false,
            popups = true,
            xray = true
        },
    },

    animations = {
        enabled = true,
    },
})
-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},       {1, 1}       } })

hl.curve("out",          { type = "bezier", points = { {0.24, 0.9},  {0.25, 0.91} } })
hl.curve("wind",         { type = "bezier", points = { {0.05, 1},    {0.1, 1.03}  } })
hl.curve("not-windy",    { type = "bezier", points = { {0.05, 1},    {0.1, 1.01}  } })
hl.curve("overshot",     { type = "bezier", points = { {0.7, 0.6},   {0.1, 1.1}   } })
hl.curve("bounce",       { type = "bezier", points = { {1.1, 1.6},   {0.1, 0.85}  } })

-- Default springs
hl.curve("easy",         { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "border",        enabled = true,  speed = 1,    bezier = "linear"                          })
hl.animation({ leaf = "windows",       enabled = true,  speed = 5,    bezier = "bounce",       style="popin"     })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 5.5,  bezier = "easeOutQuint"                    })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7,    bezier = "out",          style="popin 70%" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 7,    bezier = "wind",         style="slide"     })
hl.animation({ leaf = "fade",          enabled = true,  speed = 5.2,  bezier = "overshot"                        })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 5,    bezier = "wind"                            })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick"                           })
hl.animation({ leaf = "layers",        enabled = true,  speed = 5,    bezier = "not-windy"                       })

-- https://wiki.hypr.land/Configuring/Start/

local mocha = require("themes.catppuccin-mocha")

local function rgba(name, alpha)
    return "rgba(" .. name .. alpha .. ")"
end

local blue     = rgba(mocha.blueAlpha, "e6")
local surface0 = rgba(mocha.surface0Alpha, "e6")
local overlay0 = rgba(mocha.overlay0Alpha, "e6")

----------------
--### MONITORS ###
----------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-----------------------------
--### ENVIRONMENT VARIABLES ###
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

-----------------------
--### LOOK AND FEEL ###
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = blue,
            inactive_border = surface0,
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 6,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = false,
    },
})

hl.config({
    group = {
        col = {
            border_active   = blue,
            border_inactive = surface0,
        },

        groupbar = {
            enabled         = true,
            font_size       = 10,
            height          = 16,
            gradients       = true,
            render_titles   = true,
            text_offset     = 0,

            rounding        = 3,
            indicator_height = 3,
            indicator_gap   = 2,

            gaps_in  = 2,
            gaps_out = 2,

            col = {
                active   = overlay0,
                inactive = surface0,
            },

            text_color = mocha.text,
        },
    },
})

-------------
--### INPUT ###
-------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        -- Turns caps into a super key press as caps is the main mod key
        kb_options = "caps:super",
        kb_rules   = "",

        follow_mouse  = 1,
        accel_profile = "flat",

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- Run: hyprctl devices to get a list of devices

-- Keyboards
hl.device({ name = "logitech-k400-plus", kb_layout = "gb" })

-- Mice
hl.device({ name = "logitech-g-pro--1", sensitivity = 0 })
hl.device({ name = "logitech-k400-plus-1", sensitivity = 0, accel_profile = "adaptive", natural_scroll = true, scroll_factor = 0.2 })

require("hypr-hardware")
require("keybindings")
require("window-rules")
require("autostart")

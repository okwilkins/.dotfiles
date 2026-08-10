-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class    = "^$",
        title    = "^$",
        xwayland = true,
        float    = true,
    },

    no_initial_focus = true,
})

-- Floating windows
for _, class in ipairs({
    "^(com%.ghostty%.fastfetch)$",
    "^(com%.ghostty%.cbonsai)$",
    "^(com%.ghostty%.btm)$",
    "^imv$",
    "^org%.gnome%.FileRoller$",
    "^org%.gnome%.Nautilus$",
    "^org%.pulseaudio%.pavucontrol$",
    "^com%.github%.wwmm%.easyeffects$",
    "^io%.github%.kaii_lb%.Overskride$",
}) do
    hl.window_rule({ name = "float-" .. class, match = { class = class }, float = true })
end

-- Applies blur to wlogout interface
hl.layer_rule({
    name  = "logout-dialog-blur",
    match = { namespace = "logout_dialog" },
    blur  = true,
})

-- Noctalia background blur
hl.layer_rule({
    name  = "noctalia-blur",
    match = { namespace = "noctalia-background-.*$" },

    -- Threshold at which Noctalia starts blurring with the dimmed background opacity
    ignore_alpha = 0.35,
    blur         = true,
    blur_popups  = true,
})

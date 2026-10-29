-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
    },

    no_initial_focus = true,
})

-- Floating windows
for _, class in ipairs({
    "^(com%.ghostty%.fastfetch)$",
    "^imv$",
    "^org%.gnome%.FileRoller$",
    "^org%.gnome%.Nautilus$",
    "^org%.pulseaudio%.pavucontrol$",
    "^com%.github%.wwmm%.easyeffects$",
    "^io%.github%.kaii_lb%.Overskride$",
}) do
    hl.window_rule({ name = "float-" .. class, match = { class = class }, float = true })
end

-- Zen sets extension titles after mapping, too late for a static float rule.
local function float_zen_bitwarden_extension(window)
    if not window or not window.mapped or window.class ~= "zen-beta" or window.floating then
        return
    end

    local title = window.title:lower()
    if title:find("extension", 1, true) and title:find("bitwarden", 1, true) then
        hl.dispatch(hl.dsp.window.float({
            window = "address:" .. window.address,
            action = "enable",
        }))
    end
end

hl.on("window.open", float_zen_bitwarden_extension)
hl.on("window.title", float_zen_bitwarden_extension)
hl.on("config.reloaded", function()
    for _, window in ipairs(hl.get_windows()) do
        float_zen_bitwarden_extension(window)
    end
end)

-- The screen-sharing picker does not advertise an app class.
hl.window_rule({
    name = "float-screenshare-picker",
    match = { title = "^Select what to share$" },
    float = true,
    center = true,
})

-- Scrolling layout
hl.window_rule({ name = "scrolling-zen", match = { class = "zen-beta" }, scrolling_width = 1.0 })
hl.window_rule({ name = "scrolling-steam", match = { class = "steam" }, scrolling_width = 1.0 })
hl.window_rule({ name = "scrolling-steam-games", match = { class = "steam_app_.*" }, scrolling_width = 1.0 })

-- Applies blur to wlogout interface
hl.layer_rule({
    name = "logout-dialog-blur",
    match = { namespace = "logout_dialog" },
    blur = true,
})

-- Noctalia bar / panel / notification blur (v5 namespaces)
hl.layer_rule({
    name = "noctalia-blur",
    match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },

    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})

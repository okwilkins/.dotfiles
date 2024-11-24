local wezterm = require("wezterm")

-- Base config
local config = {
    color_scheme = "Catppuccin Mocha",
    enable_tab_bar = false,
    font_size = 16.0,
    font = wezterm.font("FiraMono Nerd Font Mono"),
    macos_window_background_blur = 30,
    window_background_opacity = 0.95,
    window_decorations = "RESIZE",
    keys = {
        {
            key = "f",
            mods = "CTRL",
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key = "'",
            mods = "CTRL",
            action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
        },
    },
    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
}

-- Add WSL config if running under WSL
if wezterm.running_under_wsl() then
    config.default_domain = "WSL:Ubuntu"
    config.wsl_domains = {
        {
            name = "WSL:Ubuntu",
            distribution = "Ubuntu",
        },
    }
end

return config

{ pins, osConfig, ... }:
{
  programs.ghostty = {
    enable = true;
  };
  home.file."${osConfig.system.xdg.configDir}/ghostty/config".text = ''
    maximize = true

    window-decoration = none
    window-padding-balance = true

    background-opacity = 0.90
    background-blur = true

    mouse-hide-while-typing = true

    theme = "Catppuccin Mocha"

    font-family = "FiraCode Nerd Font Mono"

    keybind = "ctrl+shift+f=toggle_fullscreen"
    keybind = "ctrl+shift+m=toggle_maximize"
    # Vim-like navigation
    keybind = "ctrl+shift+u=scroll_page_lines:-33"
    keybind = "ctrl+shift+d=scroll_page_lines:33"

    # Cursor shader
    custom-shader = ${pins.ghostty-cursor-shaders}/ghostty/cursor_warp.glsl
  '';
  programs.foot = {
    enable = true;
  };
}

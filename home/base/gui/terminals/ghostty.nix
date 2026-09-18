{ pkgs, osConfig, ... }:
let
  ghosttyCursorShadersRepo = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "0a274beac8b93ee6ce6b94402b7313a0417b8e38";
    hash = "sha256-B7B6K7Ee4uJlW8zzLP3ILgddnbcIQyNimY+rVllzbR0=";
  };
in
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
    # https://github.com/sahaj-b/ghostty-cursor-shaders/blob/0a274beac8b93ee6ce6b94402b7313a0417b8e38/README.md
    custom-shader = ${ghosttyCursorShadersRepo}/cursor_warp.glsl
  '';
}

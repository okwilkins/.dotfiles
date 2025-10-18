# https://nixos.wiki/wiki/Fonts
# To find font family names:
# fc-list : family | fzf

{ pkgs, ... }:
{
  fonts = {
    # Use fonts specified by the user rather than the default ones
    enableDefaultPackages = false;
    packages = import ../../base/fonts.nix { inherit pkgs; };
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Serif Simiplified Chinese"
          "Noto Serif Traditional Chinese"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans Simiplified Chinese"
          "Noto Sans Traditional Chinese"
        ];
        monospace = [ "FiraMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
      antialias = true;
    };
  };
}

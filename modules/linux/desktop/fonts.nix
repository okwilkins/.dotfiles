# https://nixos.wiki/wiki/Fonts
# To find font family names:
# fc-list : family | fzf

{ pkgs, ... }:
{
  fonts = {
    # Use fonts specified by the user rather than the default ones
    enableDefaultPackages = false;
    packages = with pkgs; [
      # Icon fonts
      material-design-icons
      font-awesome

      # Nerd fonts
      nerd-fonts.symbols-only
      nerd-fonts.fira-mono

      # Noto fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      # Misc fonts
      inter
    ];
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

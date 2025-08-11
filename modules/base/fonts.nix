# https://nixos.wiki/wiki/Fonts

{ pkgs, ... }: {
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
      noto-fonts-color-emoji
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

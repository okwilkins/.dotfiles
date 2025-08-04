{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Core tools
    wl-clipboard

    # GUI
    waybar
  ];
}

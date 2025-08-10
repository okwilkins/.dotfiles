{ pkgs, projectVars, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    xserver.enable = false;
    # https://nixos.wiki/wiki/Greetd
    # Greetd is a minimal login manager
    # It is primarily used to start Hyprland on login
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = projectVars.username;
          command = "hyprland";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Core tools
    wl-clipboard

    # GUI
    waybar
  ];
}

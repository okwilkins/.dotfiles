{ pkgs, projectVars, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [ waybar rofi-wayland ];

  # Hint Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home.file."${projectVars.xdg.configDir}/hpyr/hyprland.conf" = {
    source = ./hpyrland.conf;
  };
}

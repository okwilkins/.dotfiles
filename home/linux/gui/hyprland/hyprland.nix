{
  osConfig,
  pkgs,
  pins,
  ...
}:
{

  home.packages = with pkgs; [
    hyprshot
    # INFO: Old setup using the hyprland applications
    # hyprpaper
    # hyprlock
    # hypridle
    # hyprlauncher
    # hyprsunset
  ];

  # Desktop portals require an active graphical session, even without UWSM.
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland compositor session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
      PropagatesStopTo = [ "graphical-session.target" ];
    };
  };

  home.file."${osConfig.system.xdg.configDir}/hypr/" = {
    source = ./config;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/hypr/themes/catppuccin-mocha.lua" = {
    source = "${pins.catppuccin-hyprland}/themes/catppuccin-mocha.lua";
  };
}

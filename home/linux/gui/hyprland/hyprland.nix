{ projectVars, ... }: {
  home.file."${projectVars.xdg.configDir}/hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };
}

{ pkgs, osConfig, ... }:
{
  # INFO: Old setup using the hyprland applications
  # home.packages = with pkgs; [ anyrun ];
  # home.file."${osConfig.system.xdg.configDir}/anyrun" = {
  #   source = ./config;
  #   recursive = true;
  # };
}

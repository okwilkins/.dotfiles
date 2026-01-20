{ pkgs, osConfig, ... }:
{
  # INFO: Old setup using the hyprland applications
  # home.packages = with pkgs; [ wlogout ];
  # home.file."${osConfig.system.xdg.configDir}/wlogout" = {
  #   source = ./config;
  #   recursive = true;
  # };
}

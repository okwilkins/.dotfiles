{ pkgs, osConfig, ... }:
{
  # INFO: Old setup using the hyprland applications
  # home.packages = with pkgs; [ waybar ];
  # home.file."${osConfig.system.xdg.configDir}/waybar" = {
  #   source = ./config;
  #   recursive = true;
  # };
  # # Glitched when changing sound source, the title doesn't update
  # home.file."${osConfig.system.xdg.configDir}/waybar/scripts" = {
  #   source = ./scripts;
  #   recursive = true;
  # };
}

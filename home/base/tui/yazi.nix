{
  pkgs,
  pins,
  osConfig,
  ...
}:
{
  home.packages = [ pkgs.yazi ];
  home.file."${osConfig.system.xdg.configDir}/yazi/yazi.toml" = {
    source = ./yazi/yazi.toml;
  };
  home.file."${osConfig.system.xdg.configDir}/yazi/theme.toml" = {
    source = "${pins.catppuccin-yazi}/themes/mocha/catppuccin-mocha-blue.toml";
  };
}

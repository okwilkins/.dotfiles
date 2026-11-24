{
  pkgs,
  osConfig,
  pins,
  ...
}:
{
  home.packages = [ pkgs.k9s ];
  home.file."${osConfig.system.xdg.configDir}/k9s" = {
    source = ./k9s;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/k9s/skins" = {
    source = "${pins.catppuccin-k9s}/dist";
    recursive = true;
  };
}

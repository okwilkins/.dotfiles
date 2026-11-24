{
  pkgs,
  osConfig,
  pins,
  ...
}:
{
  home.packages = [ pkgs.gh-dash ];
  home.file."${osConfig.system.xdg.configDir}/gh-dash" = {
    source = ./gh-dash;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/gh-dash/themes/catppuccin-mocha-blue.yml" = {
    source = "${pins.catppuccin-gh-dash}/themes/mocha/catppuccin-mocha-blue.yml";
  };
}

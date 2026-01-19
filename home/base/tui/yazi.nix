{
  pkgs,
  osConfig,
  ...
}:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "fc69d6472d29b823c4980d23186c9c120a0ad32c";
    hash = "sha256-Og33IGS9pTim6LEH33CO102wpGnPomiperFbqfgrJjw=";
  };
in
{
  home.packages = [ pkgs.yazi ];
  home.file."${osConfig.system.xdg.configDir}/yazi/yazi.toml" = {
    source = ./yazi/yazi.toml;
  };
  home.file."${osConfig.system.xdg.configDir}/yazi/theme.toml" = {
    source = "${catppuccinRepo}/themes/mocha/catppuccin-mocha-blue.toml";
  };
}

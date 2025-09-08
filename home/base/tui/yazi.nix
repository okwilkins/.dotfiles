{
  pkgs,
  projectVars,
  ...
}:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "043ffae14e7f7fcc136636d5f2c617b5bc2f5e31";
    hash = "sha256-zkL46h1+U9ThD4xXkv1uuddrlQviEQD3wNZFRgv7M8Y=";
  };
in
{
  home.packages = [ pkgs.yazi ];
  home.file."${projectVars.xdg.configDir}/yazi/yazi.toml" = {
    source = ./yazi/yazi.toml;
  };
  home.file."${projectVars.xdg.configDir}/yazi/theme.toml" = {
    source = "${catppuccinRepo}/themes/mocha/catppuccin-mocha-blue.toml";
  };
}

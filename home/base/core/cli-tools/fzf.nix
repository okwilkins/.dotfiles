{ pkgs, osConfig, ... }:
let
  catppuccinRepo = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fzf";
    rev = "7c2e05606f2e75840b1ba367b1f997cd919809b3";
    hash = "sha256-fs3bOs1vfrtuono0yg1xjTSpzoS5m8ZRMD+CjAp+sDU=";
  };
in
{
  home.packages = with pkgs; [
    fzf
  ];
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/catppuccin-fzf-mocha.sh" = {
    source = "${catppuccinRepo}/themes/catppuccin-fzf-mocha.sh";
  };
}

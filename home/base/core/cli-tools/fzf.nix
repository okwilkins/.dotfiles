{
  pkgs,
  osConfig,
  pins,
  ...
}:
{
  home.packages = with pkgs; [
    fzf
  ];
  home.file."${osConfig.system.xdg.configDir}/zsh/plugins/catppuccin-fzf-mocha.sh" = {
    source = "${pins.catppuccin-fzf}/themes/catppuccin-fzf-mocha.sh";
  };
}

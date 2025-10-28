{ osConfig, config, ... }:
{
  programs.neovim = {
    enable = true;
  };
  home.file."${osConfig.system.xdg.configDir}/nvim" = {
    source = ./neovim;
    recursive = true;
  };

  home.file."${osConfig.system.xdg.configDir}/nvim/lazy-lock.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.system.dotfilesDir}/home/base/tui/neovim/lazy-lock.json";
  };
}

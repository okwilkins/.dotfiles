{ osConfig, config, ... }:
{
  programs.neovim = {
    enable = true;
  };

  home.file."${osConfig.system.xdg.configDir}/nvim/lua" = {
    source = ./neovim/lua;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/nvim/init.lua" = {
    source = ./neovim/init.lua;
  };

  home.file."${osConfig.system.xdg.configDir}/nvim/lazy-lock.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.system.dotfilesDir}/home/base/tui/neovim/lazy-lock.json";
  };
  home.file."${osConfig.system.xdg.configDir}/nvim/spell" = {
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.system.dotfilesDir}/home/base/tui/neovim/spell";
    recursive = true;
  };
}

{
  osConfig,
  config,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    # INFO:
    # evaluation warning: The default value of `programs.neovim.withRuby` has changed from `true` to `false`.
    #                     You are currently using the legacy default (`true`) because `home.stateVersion` is less than "26.05".
    #                     To silence this warning and keep legacy behavior, set:
    #                       programs.neovim.withRuby = true;
    #                     To adopt the new default behavior, set:
    #                       programs.neovim.withRuby = false;
    withRuby = false;
    # INFO:
    # evaluation warning: The default value of `programs.neovim.withPython3` has changed from `true` to `false`.
    #                     You are currently using the legacy default (`true`) because `home.stateVersion` is less than "26.05".
    #                     To silence this warning and keep legacy behavior, set:
    #                       programs.neovim.withPython3 = true;
    #                     To adopt the new default behavior, set:
    #                       programs.neovim.withPython3 = false;
    withPython3 = false;
    initLua = builtins.readFile ./neovim/init.lua;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };
  # INFO: Treesitter CLI is a requirement in nvim 0.12+ to get TS working
  home.packages = [ pkgs.tree-sitter ];

  home.file."${osConfig.system.xdg.configDir}/nvim/lua" = {
    source = ./neovim/lua;
    recursive = true;
  };

  home.file."${osConfig.system.xdg.configDir}/nvim/lazy-lock.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.system.dotfilesDir}/home/base/tui/neovim/lazy-lock.json";
  };
  home.file."${osConfig.system.xdg.configDir}/nvim/spell" = {
    source = config.lib.file.mkOutOfStoreSymlink "${osConfig.system.dotfilesDir}/home/base/tui/neovim/spell";
    recursive = true;
  };
}

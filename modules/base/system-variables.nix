{ projectVars, ... }: {
  environment.variables = {
    # Editors
    # For security reasons, do not load Neovim's user config
    # since EDITOR may be used to edit some critical files
    EDITOR = "nvim --clean";
    VISUAL = "nvim --clean";

    # XDG
    XDG_CONFIG_HOME = projectVars.xdg.configHome;
    XDG_DATA_HOME = projectVars.xdg.dataHome;
    XDG_CACHE_HOME = projectVars.xdg.cacheHome;

    # Zsh
    ZDOTDIR = "${projectVars.xdg.configHome}/zsh";
  };
}

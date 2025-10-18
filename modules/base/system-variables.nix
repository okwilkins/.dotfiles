{ config, ... }:
{
  environment.variables = {
    # Editors
    # For security reasons, do not load Neovim's user config
    # since EDITOR may be used to edit some critical files
    EDITOR = "nvim --clean";
    VISUAL = "nvim --clean";

    # XDG
    XDG_CONFIG_HOME = config.system.xdg.configHome;
    XDG_DATA_HOME = config.system.xdg.dataHome;
    XDG_CACHE_HOME = config.system.xdg.cacheHome;

    # Zsh
    ZDOTDIR = config.system.zshDotDir;

    # GNOME
    GTK_THEME = "Dracula:dark";
  };
}

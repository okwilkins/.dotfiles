{ pkgs, projectVars, ... }:
{
  home.file."${projectVars.xdg.configDir}/zsh" = {
    source = ./zsh;
    recursive = true;
  };

  # Zsh config files
  home.file."${projectVars.xdg.configDir}/zsh/.zshenv".text = ''
    # Zsh
    export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
    export HISTSIZE=10000                   # Maximum events for internal history
    export SAVEHIST=10000                   # Maximum events in history file


    # Talos OS
    export TALOSCONFIG=$XDG_CONFIG_HOME/talos/talosconfig

    # Rainfrog
    export RAINFROG_CONFIG=$XDG_CONFIG_HOME/rainfrog/config.toml

    # Dagger
    export DAGGER_NO_NAG=1

    # Programming
    # Go
    export GOPATH="$WORKSPACE/go"
    export GOBIN="$WORKSPACE/go/bin"
    export GOCACHE="$XDG_CACHE_HOME/go-build"
  '';

  home.file."${projectVars.xdg.configDir}/zsh/.zshrc".text = ''
    # Autocompletions
    autoload -U compinit; compinit

    # Plugins
    for plugin in $XDG_CONFIG_HOME/zsh/plugins/*.zsh; do
      source "$plugin"
    done
    for plugin in $XDG_CONFIG_HOME/zsh/plugins/*.sh; do
      source "$plugin"
    done
    for plugin in $XDG_CONFIG_HOME/zsh/plugins/*.bash; do
      source "$plugin"
    done

    # Styling for carapace
    zstyle ':completion:*' format $'\e[2;37m%d\e[m'


    # Navigation
    setopt CORRECT # Try to correct the spelling of commands
    source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    # fzf-tab
    source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
    source "${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh"
    # Make completions case-insensitive
    zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"


    # History
    setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
    setopt SHARE_HISTORY            # Share history between all sessions.
    setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
    setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
    setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
    setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
    setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
    setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
    setopt HIST_VERIFY              # Do not execute immediately upon history expansion.


    # Aliases
    source $XDG_CONFIG_HOME/zsh/aliases/uutils-coreutils-aliases.zsh
    source $XDG_CONFIG_HOME/zsh/aliases/aliases.zsh


    # oh-my-zsh Plugins
    source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/git/git.plugin.zsh"
    source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh"
    source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/docker/docker.plugin.zsh"
    source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/terraform/terraform.plugin.zsh"
  '';
}

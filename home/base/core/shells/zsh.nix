{ pkgs, projectVars, ... }: {
  home.packages = with pkgs; [ zsh-autosuggestions zsh-syntax-highlighting ];
  home.file."${projectVars.xdg.configHome}/zsh/.zshenv".text = ''
    export WORKSPACE="$HOME/workspace"
    export DOTFILES="$HOME/.dotfiles"

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

  home.file."${projectVars.xdg.configHome}/zsh/.zshenv".text = ''
    # Start Tmux on shell start and attempt to attach to the last session
    if [ -z "$TMUX" ]; then
        LAST_SESSION=$(tmux list-sessions -F "#{session_name}" | tail -n1)
        if [ -n "$LAST_SESSION" ]; then
            tmux attach -t "$LAST_SESSION"
        else
            tmux new -s new_session
        fi
    fi

    # Autocompletions
    autoload -U compinit; compinit
    # TODO: Make home link this file somewhere, DO NOT USER DOTFILES dir!
    fpath=($DOTFILES/configs/zsh/completions/ $fpath)


    # Plugins
    # TODO: Enable this when Zsh plugins are installed again
    # for plugin in $DOTFILES/configs/zsh/plugins/*.zsh; do
    #   source "$plugin"
    # done

    source <(fzf --zsh)
    eval "$(zoxide init zsh)"
    source <(carapace _carapace zsh)

    # Style
    eval "$(starship init zsh)"
    # Styling for carapace
    zstyle ':completion:*' format $'\e[2;37m%d\e[m'


    # Navigation
    setopt CORRECT # Try to correct the spelling of commands

    source $DEVBOX_GLOBAL_SHARE/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $DEVBOX_GLOBAL_SHARE/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # fzf-tab
    source $DEVBOX_GLOBAL_SHARE/fzf-tab/fzf-tab.plugin.zsh
    zstyle ":fzf-tab:*" fzf-flags \
        --height "90%" --layout=reverse --border \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#a6e3a1 \
        --color=fg:#cdd6f4,header:#a6e3a1,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#a6e3a1 \
        --color=selected-bg:#45475a
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
    source $DOTFILES/aliases/coreutils.zsh
    source $DOTFILES/aliases/aliases.zsh
  '';
}

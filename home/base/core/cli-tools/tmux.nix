{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    tmux
    tmuxPlugins.yank
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.catppuccin
    tmuxPlugins.tmux-sessionx
  ];

  home.file."${osConfig.system.xdg.configDir}/tmux" = {
    source = ./tmux;
    recursive = true;
  };
  home.file."${osConfig.system.xdg.configDir}/tmux/tmux.conf".text = ''
    source-file ${osConfig.system.xdg.configDir}/tmux/tmux.keybinds.conf
    set-option -g default-terminal 'screen-256color'
    set-option -g terminal-overrides ',xterm-256color:RGB'

    set -g prefix ^S
    set -g base-index 1              # start indexing windows at 1 instead of 0
    set -g detach-on-destroy off     # don't exit from tmux when closing a session
    set -g escape-time 0             # zero-out escape time delay
    set -g history-limit 1000000     # increase history size (from 2,000)
    set -g renumber-windows on       # renumber all windows when any window is closed
    set -g set-clipboard on          # use system clipboard
    set -g status-position top 
    set -g default-terminal "''${TERM}"
    setw -g mode-keys vi
    set -g mouse on

    # Setting to help Neovim's colours be correct
    set -g default-terminal "xterm-256color"

    # Plugins

    # Catppuccin settings
    set -g @catppuccin_window_left_separator ""
    set -g @catppuccin_window_right_separator " "
    set -g @catppuccin_window_middle_separator " █"
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_default_fill "number"
    set -g @catppuccin_window_default_text "#W"
    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
    set -g @catppuccin_status_modules_right "directory date_time"
    set -g @catppuccin_status_modules_left "session"
    set -g @catppuccin_status_left_separator  " "
    set -g @catppuccin_status_right_separator " "
    set -g @catppuccin_status_right_separator_inverse "no"
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_connect_separator "no"
    set -g @catppuccin_directory_text "#{b:pane_current_path}"
    set -g @catppuccin_date_time_text "%H:%M"

    run ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

    # Tmux Yank
    run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux

    # Tmux Resurrect
    run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
    # Additional list of processes Resurrect is allowed restore
    set -g @resurrect-processesses "k9s" 
    set -g @resurrect-strategy-nvim "session"
    set -g @resurrect-strategy-vim "session"
    set -g @resurrect-capture-pane-contents 'on'
    RESURRECT_DIR="$XDG_CONFIG_HOME/tmux/resurrect"
    TARGET="$(readlink -f $RESURRECT_DIR/last)"
    set -g @resurrect-dir $RESURRECT_DIR
    # Remove extra args to nvim
    set -g @resurrect-hook-post-save-all "sed 's/--cmd[^ ]* [^ ]* [^ ]*//g' $TARGET | sponge $TARGET" 

    # Tmux Continuum
    run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
    set -g @continuum-boot 'on'
    set -g @continuum-restore 'on'

    # Vim Tmux Navigator
    run ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux

    # Tmux Sessionx
    set -g @sessionx-bind "l"
    # Custom paths to be displayed as placeholders
    set -g @sessionx-custom-paths "$DOTFILES"
    set -g @sessionx-zoxide-mode 'on'

    # Make sure this is run after configuring settings otherwise it wont load?
    run-shell ${pkgs.tmuxPlugins.tmux-sessionx}/share/tmux-plugins/sessionx/sessionx.tmux
  '';
}

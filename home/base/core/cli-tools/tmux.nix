{ pkgs, projectVars, ... }: {
  home.packages = with pkgs; [
    tmux
    tmuxPlugins.yank
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    tmuxPlugins.vim-tmux-navigator
  ];

  home.file."${projectVars.xdg.configDir}/tmux" = { source = ./tmux; };
}


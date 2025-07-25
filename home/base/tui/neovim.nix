{ ... }: {
  programs.neovim = { enable = true; };
  home.file.".config/nvim" = {
    source = ./neovim;
    recursive = true;
  };
}

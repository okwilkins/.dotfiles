{ ... }: {
  programs.neovim = { enable = true; };
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}

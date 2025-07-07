{...}: {
  programs.neovim = {
    enable = true;
  };
  home.file.".config/nvim" = {
    source = ../../../../configs/nvim;
    recursive = true;
  };
}

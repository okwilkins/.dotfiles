{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    starship
    eza
    bat
    ripgrep
    zoxide
    fzf
    yq-go
    jq
    tmux
    yazi
    lazygit
    hyperfine
    xh
    fd
    dust
    # coreutils-full
    # moreutils
    # uutils-coreutils
    parallel
    bottom
    delta
    htop
    carapace
  ];

  home.file.".config/bat" = { source = ./bat; };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file.".config/git" = { source = ./git; };

  home.file.".config/yazi" = { source = ./yazi; };

  home.file.".config/tmux" = { source = ./tmux; };

  home.file.".config/lazygit/config.yml" = { source = ./lazygit/config.yaml; };
}

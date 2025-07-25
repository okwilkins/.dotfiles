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

  home.file.".config/bat" = { source = ../../../../configs/bat; };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file.".config/git" = { source = ../../../../configs/git; };

  home.file.".config/yazi" = { source = ../../../../configs/yazi; };

  home.file.".config/tmux" = { source = ../../../../configs/tmux; };

  home.file.".config/lazygit/config.yml" = {
    source = ../../../../configs/lazygit/config.yaml;
  };
}

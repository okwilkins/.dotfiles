{pkgs, ...}: {
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
  ];
}

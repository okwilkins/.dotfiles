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
  ];
}

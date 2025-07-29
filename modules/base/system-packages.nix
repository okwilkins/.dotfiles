{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git
    wl-clipboard
  ];

  programs.zsh = { enable = true; };
  users.defaultUserShell = pkgs.zsh;
}

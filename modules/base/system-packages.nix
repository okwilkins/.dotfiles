{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git

    # Achieves
    gnutar

    # Misc
    wl-clipboard
  ];

  programs.zsh = { enable = true; };
  users.defaultUserShell = pkgs.zsh;
}

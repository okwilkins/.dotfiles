{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git
    npins

    # Achieves
    gnutar

    wl-clipboard
  ];

  programs.zsh = {
    enable = true;
  };
}

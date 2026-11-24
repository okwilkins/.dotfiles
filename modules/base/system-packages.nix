{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git
    npins

    # Achieves
    gnutar
  ];

  programs.zsh = {
    enable = true;
  };
}

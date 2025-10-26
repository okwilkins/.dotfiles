{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git

    # Achieves
    gnutar
  ];

  programs.zsh = {
    enable = true;
  };
}

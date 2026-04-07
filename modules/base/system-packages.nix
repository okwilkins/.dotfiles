{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git

    # Achieves
    gnutar

    wl-clipboard
  ];

  programs.zsh = {
    enable = true;
  };
}

{ pkgs, ... }:

# To be used in Linux/Darwin fonts.nix only
with pkgs;
[
  # Icon fonts
  material-design-icons
  font-awesome

  # Nerd fonts
  nerd-fonts.symbols-only
  nerd-fonts.fira-mono

  # Noto fonts
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-cjk-serif
  noto-fonts-color-emoji

  # Misc fonts
  inter
]

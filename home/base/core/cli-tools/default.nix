{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  imports = [
    ./tmux.nix
    ./fzf.nix
  ];
  home.packages = with pkgs; [
    starship
    eza
    bat
    ripgrep
    zoxide
    fzf
    yq-go
    jq
    lazygit
    hyperfine
    xh
    fd
    dust
    coreutils-full
    moreutils
    uutils-coreutils
    delta
    htop
    carapace
    ouch
    rar
    dnsutils
  ];

  home.file."${osConfig.system.xdg.configDir}/bat" = {
    source = ./bat;
    recursive = true;
  };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file."${osConfig.system.xdg.configDir}/git" = {
    source = ./git;
    recursive = true;
  };

  home.file."${osConfig.system.xdg.configDir}/lazygit" = {
    source = ./lazygit;
    recursive = true;
  };
}

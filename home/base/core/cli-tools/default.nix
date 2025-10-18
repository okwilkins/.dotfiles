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
  };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file."${osConfig.system.xdg.configDir}/git" = {
    source = ./git;
  };

  home.file."${osConfig.system.xdg.configDir}/lazygit/config.yml" = {
    source = ./lazygit/config.yaml;
  };
}

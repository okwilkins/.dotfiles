{
  pkgs,
  lib,
  projectVars,
  ...
}:
{
  imports = [ ./tmux.nix ];
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

  home.file."${projectVars.xdg.configDir}/bat" = {
    source = ./bat;
  };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file."${projectVars.xdg.configDir}/git" = {
    source = ./git;
  };

  home.file."${projectVars.xdg.configDir}/lazygit/config.yml" = {
    source = ./lazygit/config.yaml;
  };
}

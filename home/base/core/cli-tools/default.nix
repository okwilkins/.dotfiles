{ pkgs, lib, projectVars, ... }: {
  home.packages = with pkgs; [
    starship
    eza
    bat
    ripgrep
    zoxide
    fzf
    yq-go
    jq
    tmux
    yazi
    lazygit
    hyperfine
    xh
    fd
    dust
    coreutils-full
    moreutils
    uutils-coreutils
    bottom
    delta
    htop
    carapace
  ];

  home.file."${projectVars.xdg.configDir}/bat" = { source = ./bat; };
  home.activation.batCacheRebuild = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.file."${projectVars.xdg.configDir}/git" = { source = ./git; };

  home.file."${projectVars.xdg.configDir}/yazi" = { source = ./yazi; };

  home.file."${projectVars.xdg.configDir}/tmux" = { source = ./tmux; };

  home.file."${projectVars.xdg.configDir}/lazygit/config.yml" = {
    source = ./lazygit/config.yaml;
  };
}

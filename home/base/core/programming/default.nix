# TODO: Seperate this file out of base as servers DEFFO do not want all of these things
{ pkgs, osConfig, ... }:
let
  registryHost = "harbor.okwilkins.dev";
in
{
  imports = [
    (import ./docker.nix { inherit pkgs osConfig registryHost; })
    (import ./buildah.nix { inherit pkgs osConfig registryHost; })
  ];

  home.packages = with pkgs; [
    zig
    go
    gcc
    python312
    poetry
    # Cloud/Devops
    awscli2
    kubectl
    kubernetes-helm
    cosign
    talosctl
    go-task
    terraform
    opentofu
    cilium-cli
    clang-tools
    # LSPs
    nixd
    lua-language-server
    marksman
    pyright
    gopls
    terraform-ls
    yaml-language-server
    vscode-langservers-extracted
    zls
    # Formatters
    nixfmt-rfc-style
    stylua
    ruff
    yamlfmt
    # Debuggers
    lldb
  ];

  home.file."${osConfig.system.xdg.configDir}/yamlfmt/.yamlfmt" = {
    source = ./yamlfmt/config.yaml;
  };

  home.sessionVariables.TALOSCONFIG = "${osConfig.system.xdg.configHome}/talos/talosconfig";
  home.sessionVariables.RAINFROG_CONFIG = "${osConfig.system.xdg.configHome}/rainfrog/config.toml";
  home.sessionVariables.GOPATH = "${osConfig.system.homeDir}/go";
  home.sessionVariables.GOBIN = "${osConfig.system.homeDir}/go/bin";
  home.sessionVariables.GOCACHE = "${osConfig.system.xdg.cacheHome}/go-build";
}

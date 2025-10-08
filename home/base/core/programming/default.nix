{ pkgs, ... }:
{
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
  ];
}

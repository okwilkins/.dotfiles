{ pkgs, ... }: {
  home.packages = with pkgs; [
    zig
    go
    # LSPs
    nixd
    lua-language-server
    marksman
    pyright
    gopls
    terraform-ls
    # Formatters
    nixfmt
    stylua
    ruff
  ];
}

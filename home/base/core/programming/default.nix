{ pkgs, ... }: {
  home.packages = with pkgs; [
    zig
    go
    gcc
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

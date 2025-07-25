{pkgs, ...}: {
  home.packages = with pkgs; [
    zig
    # LSPs
    nixd
    # Formatters
    nixfmt
  ];
}

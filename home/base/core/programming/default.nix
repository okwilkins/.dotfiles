{pkgs, ...}: {
  home.packages = with pkgs; [
    zig
  ];
}

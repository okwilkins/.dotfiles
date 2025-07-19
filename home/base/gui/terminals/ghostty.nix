{...}: {
  programs.ghostty = {
    enable = true;
  };
  home.file.".config/ghostty/config" = {
    source = ./config;
  };
}

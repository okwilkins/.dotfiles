{pkgs, ...}: {
  # For security reasons, do not load Neovim's user config
  # since EDITOR may be used to edit some critical files
  environment.variables.EDITOR = "nvim --clean";

  environment.systemPackages = with pkgs; [
    # Core tools
    neovim
    git
  ];

  programs.zsh = {
    enable = true;
  };
}

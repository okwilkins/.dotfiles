{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # Core tools
      wl-clipboard
    ];
}

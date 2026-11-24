{
  pkgs,
  osConfig,
  pins,
  ...
}:
{
  imports = [
    ./hex.nix
    ./hyprland
    # INFO: Old setup using the hyprland applications
    # ./anyrun
    # ./waybar
    # ./wlogout
    # ./swaync
    ./libre_pods.nix
    ./noctalia.nix
    ./steam.nix
    ./xdg.nix
  ];

  home.file."${osConfig.system.xdg.dataDir}/icons/rose-pine-hyprcursor".source =
    pins.rose-pine-hyprcursor;

  home.packages = with pkgs; [
    # Discord
    legcord
    easyeffects
    overskride
    playerctl
    pavucontrol
    imv
    nautilus
    # Allows for viewing archived files with Nautilus
    file-roller
  ];

  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu";
      gpu-context = "wayland";
      hwdec = "auto-safe";
    };
  };

  # https://nixos.wiki/wiki/GNOME#Dark_mode
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };
}

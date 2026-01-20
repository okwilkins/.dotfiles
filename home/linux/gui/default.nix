{ pkgs, osConfig, ... }:
let
  rosePineCursorHyprcursor = pkgs.fetchFromGitHub {
    owner = "ndom91";
    repo = "rose-pine-hyprcursor";
    rev = "v0.3.2";
    sha256 = "sha256-ArUX5qlqAXUqcRqHz4QxXy3KgkfasTPA/Qwf6D2kV0U=";
  };
in
{
  imports = [
    ./hyprland
    # INFO: Old setup using the hyprland applications
    # ./anyrun
    # ./waybar
    # ./wlogout
    # ./swaync
    ./noctalia.nix
    ./xdg.nix
  ];

  home.file."${osConfig.system.xdg.dataDir}/icons/rose-pine-hyprcursor".source = "${
    rosePineCursorHyprcursor
  }";

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
    iconTheme = {
      package = pkgs.dracula-icon-theme;
      name = "Dracula";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };
}

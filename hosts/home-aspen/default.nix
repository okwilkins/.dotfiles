{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Settings to get containerisation working for this host
  boot.isContainer = true;

  # Disable networking hardware management (Podman handles this)
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.hostName = "aspen-nixos";
  # Trust the DNS provided by Podman
  networking.resolvconf.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.system.username} = {
    isNormalUser = true;
    description = config.system.userFullname;
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

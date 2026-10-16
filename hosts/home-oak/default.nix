{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # QEMU system emulation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # Stops containerised workloads from complaining about dynamically linked libs not existing
  boot.binfmt.preferStaticEmulators = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.greeter = "noctalia";

  # Matches hypr-hardware.lua
  services.displayManager.noctalia-greeter.settings.output = {
    layout = "DP-4:0,0; DP-5:2560,0; HDMI-A-5:5120,0";
    scales = "DP-4:1.5; DP-5:1; HDMI-A-5:2";
    refresh_rate = "DP-4:60; DP-5:144; HDMI-A-5:120";
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "oak-nixos";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.system.username} = {
    isNormalUser = true;
    description = config.system.userFullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Show battery charge of Bluetooth devices
        Experimental = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

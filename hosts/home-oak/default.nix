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

  boot.initrd.luks.devices."luks-c461448d-dc40-45ae-98cd-29b002e5b790".device =
    "/dev/disk/by-uuid/c461448d-dc40-45ae-98cd-29b002e5b790";

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

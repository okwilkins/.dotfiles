# https://nixos.wiki/wiki/Nvidia

{ config, ... }:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management. Experimental and can cause sleep/suspend to fail.
    # Enable the if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the Nvidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # For newer cards RTX 20-series onwards it's recommended by Nvidia to use the open drivers
    open = true;

    # Enable the Nvidia settings menu, accessible via `nvidia-settings`
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}

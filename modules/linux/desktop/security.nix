{ pkgs, ... }:
{
  security.polkit.enable = true;

  services.udev.packages = [
    pkgs.yubikey-personalization
  ];
  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;
}

{ lib, pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # INFO: https://nixos.wiki/wiki/Yubikey#pam_u2f
  # To add more security keys read here
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}

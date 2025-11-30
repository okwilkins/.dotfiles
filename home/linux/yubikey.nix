{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yubikey-manager
    pam_u2f
  ];
}

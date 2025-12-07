{ ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # INFO: https://nixos.wiki/wiki/Yubikey#pam_u2f
  # To add more security keys read here
  security.pam.u2f = {
    enable = true;
    settings = {
      cue = true;
      pinverification = true;
    };
  };
}

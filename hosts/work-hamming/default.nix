{ pkgs, ... }:
{
  # # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.oli = {
  #   isNormalUser = true;
  #   description = "Oliver Wilkins";
  #   extraGroups = [
  #     "networkmanager"
  #     "wheel"
  #   ];
  #   shell = pkgs.zsh;
  # };
  #
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = 6;
}

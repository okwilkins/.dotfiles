{ pkgs, ... }:
{
  users.users."oliver.wilkins" = {
    description = "Oliver Wilkins";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = 6;
}

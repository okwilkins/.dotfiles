{
  pkgs,
  config,
  ...
}:
{
  system.username = "oliver.wilkins";
  system.userEmail = "oliver.wilkins@likezero.co.uk";

  users.users.${config.system.username} = {
    description = "Oliver Wilkins";
    shell = pkgs.zsh;
    home = config.system.homeDir;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = 6;
}

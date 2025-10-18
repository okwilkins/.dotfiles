{ pkgs, projectVars, ... }:
{
  users.users.projectVars.username.shell = pkgs.zsh;

  system = {
    primaryUser = projectVars.username;

    defaults = {
      menuExtraClock.Show24Hour = true;
      dock = {
        autohide = true;
      };
    };
  };
}

{ projectVars, ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;

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

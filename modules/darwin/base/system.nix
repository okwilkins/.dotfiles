{ projectVars, ... }:
{
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

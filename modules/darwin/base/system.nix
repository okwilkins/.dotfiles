{ config, ... }:
{
  system = {
    primaryUser = config.system.username;

    defaults = {
      menuExtraClock.Show24Hour = true;
      dock = {
        autohide = true;
      };
    };
  };
}

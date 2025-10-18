{ osConfig, ... }:
{
  imports = [ ../../home/base/home.nix ];
  home.file."${osConfig.system.xdg.configDir}/hypr/hypr-hardware.conf" = {
    source = ./hypr-hardware.conf;
  };
}

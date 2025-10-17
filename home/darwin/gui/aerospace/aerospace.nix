{ pkgs, projectVars, ... }:
{
  home.packages = with pkgs; [
    aerospace
  ];

  home.file."${projectVars.xdg.configDir}/aerospace/aerospace.toml" = {
    source = ./aerospace.toml;
  };
}

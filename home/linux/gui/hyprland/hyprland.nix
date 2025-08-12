{ projectVars, ... }:
{
  home.file."${projectVars.xdg.configDir}/hypr/" = {
    source = ./configs;
    recursive = true;
  };
}

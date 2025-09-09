{ projectVars, ... }:
{
  home.file."${projectVars.xdg.configHome}/shared/style-sheets" = {
    source = ./style-sheets;
    recursive = true;
  };
}

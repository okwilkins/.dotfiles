{ osConfig, ... }:
{
  home.file."${osConfig.system.xdg.configHome}/shared/style-sheets" = {
    source = ./style-sheets;
    recursive = true;
  };
}

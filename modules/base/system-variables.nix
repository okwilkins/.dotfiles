{ projectVars, ... }: {
  environment.sessionVariables = {
    XDG_CONFIG_HOME = projectVars.xdg.configHome;
    XDG_DATA_HOME = projectVars.xdg.dataHome;
    XDG_CACHE_HOME = projectVars.xdg.cacheHome;
  };
}

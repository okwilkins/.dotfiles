{
  osConfig,
  inputs,
  pkgs,
  ...
}:
{
  home = {
    username = osConfig.system.username;
    homeDirectory = osConfig.system.homeDir;
    packages = [
      inputs.dagger.packages.${pkgs.system}.dagger
    ];

    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };
}

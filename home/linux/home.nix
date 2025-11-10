{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with inputs; [
    hyprlauncher.packages.${pkgs.system}.hyprlauncher
  ];
}

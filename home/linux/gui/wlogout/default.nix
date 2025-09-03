{ pkgs, ... }:
{
  home.packages = with pkgs; [ wlogout ];
}

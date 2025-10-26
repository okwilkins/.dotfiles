{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  users.defaultUserShell = pkgs.zsh;
}

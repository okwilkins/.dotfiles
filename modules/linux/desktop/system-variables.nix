{ ... }: {
  environment.variables = {
    # Hint Electron apps to use Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

{ ... }:
{
  environment.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Stops GTK apps to not capture shortcuts
    # This is used to allow shift+ctrl+u for Ghostty
    GTK_IM_MODULE = "none";
  };
}

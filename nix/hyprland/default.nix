{
  pkgs,
  lib,
  hyprland,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = lib.fileContents ../../.config/hypr/hyprland.conf;
  };
}

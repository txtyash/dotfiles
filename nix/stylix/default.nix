{pkgs, ...}: let
  polarity = builtins.getEnv "POLARITY";
in
  if polarity == "dark"
  then {
    stylix.image = ../wallpapers/dark.jpeg;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    stylix.polarity = polarity;
  }
  else {
    stylix.image = ../wallpapers/light.jpg;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
    stylix.polarity = polarity;
  }

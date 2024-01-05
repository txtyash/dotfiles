# {config, ...}: {
#   stylix.image = ../pictures/landscape/vector-forest.jpg;
#   stylix.polarity = "light";
# }
{
  osConfig,
  pkgs,
  ...
}: {
  stylix = with osConfig; {
    image = profiles.yash.wall;
    polarity = profiles.yash.polarity;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${profiles.yash.theme}.yaml";
  };
}

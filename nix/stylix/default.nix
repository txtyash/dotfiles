{pkgs, ...}:  {
  stylix =
    {
      cursor.package = pkgs.catppuccin-cursors;
      image = ../../Pictures/gruv-room.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
      cursor.name = "macchiatoFlamingo";
      polarity = "light";
    };
}

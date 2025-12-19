{
  pkgs,
  ...
}:
{
  home = {
    username = "yash";
    homeDirectory = "/home/yash";
    stateVersion = "25.05";
    pointerCursor = {
      name = "Fuchsia";
      package = pkgs.fuchsia-cursor;
      size = 16;
      gtk.enable = true;
      x11.enable = true;
    };
    packages = with pkgs; [
      anki
      beekeeper-studio
      dprint
      dsearch
      fd
      fish
      gh
      ghostty
      git
      google-chrome
      lazygit
      marksman
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      protonmail-desktop
      protonvpn-gui
      ripgrep
      tldr
      tree-sitter
      yazi
      zig
    ];
  };

  programs = {
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

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
      brightnessctl
      dsearch
      fd
      fish
      fuzzel
      gcc
      gh
      ghostty
      git
      google-chrome
      lazygit
      marksman
      neovide
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      protonvpn-gui
      qbittorrent
      ripgrep
      tldr
      tree-sitter
      unzip
      yazi
    ];
    sessionPath = [
      "$HOME/go/bin"
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

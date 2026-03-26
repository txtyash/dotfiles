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
      btop
      fd
      fuzzel
      fzf
      gcc
      gh
      ghostty
      git
      google-chrome
      kew
      lazygit
      localsend
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
      vlc
      yazi
    ];
    sessionPath = [
      "$HOME/go/bin"
    ];
  };

  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      interactiveShellInit = ''
        fzf_configure_bindings --history=\cr --variables=\cv --git_status=\cs
      '';
    };
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

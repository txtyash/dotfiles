{
  pkgs,
  inputs,
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
      google-chrome
      lazygit
      marksman
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
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

    git = {
      enable = true;
      # TODO: Set editor and auth method to ssh
      settings.user = {
        name = "txtyash";
        email = "textyash@proton.me";
        core.editor = "nvim";
        init.defaultBranch = "master";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

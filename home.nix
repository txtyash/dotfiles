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
      brave
      btop
      copyq
      fd
      fish
      gh
      git
      google-chrome
      kew
      lazygit
      localsend
      marksman
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      protonvpn-gui
      qbittorrent
      ripgrep
      tree-sitter
      unzip
      vlc
      wl-clipboard
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
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

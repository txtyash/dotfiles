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
      bluetui
      brave
      btop
      claude-code
      copyq
      fd
      fish
      gh
      google-chrome
      kew
      lazygit
      localsend
      marksman
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      proton-pass
      proton-pass-cli
      proton-vpn
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
    git = {
      enable = true;
      ignores = [ ".claude/settings.json" ];
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

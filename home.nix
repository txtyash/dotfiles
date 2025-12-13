{
  pkgs,
  inputs,
  ...
}:
{
  imports = with inputs; [
    dankMaterialShell.homeModules.dankMaterialShell.niri
    dankMaterialShell.homeModules.dankMaterialShell.default
  ];
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
      dprint
      dsearch
      fd
      gemini-cli
      gh
      ghostty
      google-chrome
      lazygit
      localsend
      marksman
      neovide
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
    file = {
      ".config/lazygit".source = ./lazygit;
      ".config/nvim".source = ./nvim;
      ".config/niri".source = ./niri;
      ".config/ghostty".source = ./ghostty;
      "Pictures/wallpaper".source = pkgs.fetchurl {
        url = "https://i.imgur.com/X4hJMs7.jpg";
        sha256 = "sha256-ksPiYxfeSY1pil9rqUmxf+MW837drUddjUbNgxE0Bv0=";
      };
    };
  };

  programs = {
    dankMaterialShell = {
      enable = true;
      niri = {
        enableKeybinds = true;
        enableSpawn = true;
      };
      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
      };

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableClipboard = true; # Clipboard history manager
      enableVPN = true; # VPN management widget
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
    };
    fish = {
      enable = true;

      interactiveShellInit = ''
        fish_vi_key_bindings

        bind -M insert \cA beginning-of-line     
        bind -M insert \cE end-of-line           
        bind -M insert \cU backward-kill-line    
        bind -M insert \cK kill-line             
        bind -M insert \cW backward-kill-word    
        bind -M insert \cY yank                  
        bind -M insert \cB backward-char         
        bind -M insert \cF forward-char          
        bind -M insert \cp up-or-search
        bind -M insert \cn down-or-search

        bind -M insert \cr history-pager

        # Repaint after pressing C-c to avoid artefacts
        function cancel-cmd
            commandline ""
            emit fish_cancel
            commandline -f repaint
        end
      '';

      shellInit = ''
        set -gx EDITOR nvim
        set -g fish_greeting
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

    git = {
      enable = true;
      settings.user = {
        name = "txtyash";
        email = "textyash@proton.me";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

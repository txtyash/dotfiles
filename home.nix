{ config, pkgs, ... }:
{
  home = {
    username = "yash";
    homeDirectory = "/home/yash";
    stateVersion = "25.05";
    packages = with pkgs; [
      brave
      brightnessctl
      dprint
      fd
      fuzzel
      gh
      ghostty
      lazygit
      marksman
      neovide
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      ripgrep
      tree-sitter
      yazi
      zig
    ];
    file = {
      ".config/ghostty".source = ./ghostty;
      ".config/lazygit".source = ./lazygit;
      ".config/nvim".source = ./nvim;
      ".config/niri".source = ./niri;
    };
  };

  programs = {
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
      '';

      shellInit = ''
        set -gx EDITOR nvim
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
  };
}

{
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yash";
  home.homeDirectory = "/home/yash";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # GUI
    vlc
    scrcpy
    waybar
    oculante
    qbittorrent
    tor-browser
    hyprpicker
    warp-terminal
    protonvpn-gui
    microsoft-edge
    networkmanagerapplet

    # CLI
    gh
    fd
    fzf
    eza
    zip
    bat
    yazi
    tldr
    delta
    unzip
    nsxiv
    copyq
    bottom
    fuzzel
    zoxide
    zathura
    ripgrep
    starship
    fastfetch
    wl-clipboard
    protonvpn-cli

    # Miscellaneous
    bun
    dunst
    direnv
    pamixer
    grimblast
    nerdfonts
    brightnessctl
    kanata-with-cmd

    # LSP
    nil
    taplo
    marksman
    slint-lsp
    rust-analyzer
    lua-language-server
    yaml-language-server
    tailwindcss-language-server

    # Formatters
    yamlfmt
    alejandra
    luaformatter

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yash/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs = {
    fish = {
      enable = true;
      plugins = [
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "fzf.fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
      ];

      shellInit = lib.fileContents ../.config/fish/config.fish;
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
  imports = [
    ./stylix
  ];
  # Just link the config files for applications
  # TODO: This is repetitive. Can we link the entire .config dir recursively?
  # xdg.configFile."helix/config.toml".source = ../.config/helix/config.toml;
  # xdg.configFile."helix/languages.toml".source = ../.config/helix/languages.toml;
  # xdg.configFile."wezterm/wezterm.lua".source = ../.config/wezterm/wezterm.lua;
  # xdg.configFile."alacritty/alacritty.toml".source = ../.config/alacritty/alacritty.toml;
  # xdg.configFile."foot/foot.ini".source = ../.config/foot/foot.ini;
  # xdg.configFile."hypr/hyprland.conf".source = ../.config/hypr/hyprland.conf;
  # xdg.configFile."fuzzel/fuzzel.ini".source = ../.config/fuzzel/fuzzel.ini;
  # xdg.configFile."dunst/dunstrc".source = ../.config/dunst/dunstrc;
  # xdg.configFile."dunst/volume.sh".source = ../.config/dunst/volume.sh;
  # xdg.configFile."dunst/brightness.sh".source = ../.config/dunst/brightness.sh;
  # xdg.configFile."waybar/config".source = ../.config/waybar/config;
  # xdg.configFile."waybar/style.css".source = ../.config/waybar/style.css;
  # xdg.configFile."starship.toml".source = ../.config/starship.toml;
  # xdg.configFile."yazi/yazi.toml".source = ../.config/yazi/yazi.toml;
  # xdg.configFile."yazi/keymap.toml".source = ../.config/yazi/keymap.toml;
  # xdg.configFile."yazi/theme.toml".source = ../.config/yazi/theme.toml;
  # xdg.configFile."git/config".source = ../.config/git/config;
  # xdg.configFile."mimeapps.list".source = ../.config/mimeapps.list;
  home.file.".config" = { 
    source = ../.config; 
    recursive = true; 
  };
  home.file."Pictures" = { 
    source = ../Pictures; 
    recursive = true; 
  };
}

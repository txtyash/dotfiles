{
  config,
  pkgs,
  ...
}: {
  home.username = "yash";
  home.homeDirectory = "/home/yash";

  home.packages = with pkgs; [
    # GUI
    fuzzel # wayland application launcher
    wezterm # terminal emulator

    # Non GUI
    kanata # key binding modifier
    nerdfonts # collection of patched fonts

    # TUI
    bat # gnu cat replacement
    bottom # system monitor
    broot # file tree application
    evcxr # rust repl
    eza # A modern replacement for ‘ls’
    fastfetch # OS fetch program
    fd # find replacement
    file # nixos does not have a file command by default
    fzf # A command-line fuzzy finder
    gh # github cli
    jq # A lightweight and flexible command-line JSON processor
    lazygit # git tui frontend
    ncdu # ncurses disk usage
    nnn # tui file manager
    ripgrep # grep replacement
    sd # sed replacement
    unzip # archives
    wl-clipboard # wayland clipboard
    xplr # minimal tui file browser
    zip # archives
    zig # zig language compiler
  ];

  imports = [
    ./zoxide
    ./starship
    ./fish
    ./neovim
  ];

  home.stateVersion = "23.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

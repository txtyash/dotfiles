{
  config,
  pkgs,
  ...
}: {
  home.username = "yash";
  home.homeDirectory = "/home/yash";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Yash Shinde";
    userEmail = "evccyr@proton.me";
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    wofi
    gh
    kanata
    wezterm
    ncdu
    atuin
    fd
    sd
    nerdfonts
    bottom
    evcxr
    direnv
    wl-clipboard
    file
    broot
    lazygit
    vscode

    fastfetch # OS fetch program
    nnn # tui file manager
    xplr # minimal tui file browser

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    bat
  ];

  home.stateVersion = "23.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

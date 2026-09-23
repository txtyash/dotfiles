# RTFM
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  inputs,
  ...
}:
let
  ai = with pkgs; [
    claude-code
    antigravity-cli
  ];
  browsers = with pkgs; [
    brave
    google-chrome
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  dmsDeps = with pkgs; [
    cliphist
    dsearch
    cups-pk-helper
    wl-clipboard
  ];
  editors = with pkgs; [
    neovim
    zed-editor
    tree-sitter
  ];
  terminals = with pkgs; [
    ghostty
    foot
  ];
  utils = with pkgs; [
    btop
    fd
    fzf
    git
    gh
    ripgrep
    unzip
  ];
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # TODO: Prevent exposing hostname to wifi networks
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };

  virtualisation.docker.enable = true;

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    upower.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs31-pgtk;
    };
  };

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Shinde";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "render"
      "tty"
      "dialout"
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    dms-shell.enable = true;
    firefox.enable = true;
    fish.enable = true;
    niri.enable = true;
    zoxide = {
      enable = true;
    };
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        google-cursor
        krita
        xournalpp
        localsend

        # TODO: Add Dev Shell to ~/.config and remove these
        nil
        nixfmt

        starship
        vlc
        mpv
        nautilus
        gcc
      ]
      ++ ai
      ++ browsers
      ++ dmsDeps
      ++ editors
      ++ terminals
      ++ utils;

    variables = {
      XCURSOR_THEME = "GoogleDot-Blue";
      XCURSOR_SIZE = "21";
      EDITOR = "emacsclient -c -a nvim";
      VISUAL = "emacsclient -c -a nvim";
    };
  };
}

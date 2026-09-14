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
    inputs.helium.packages.${system}.default
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
  proton = with pkgs; [
    proton-vpn
    proton-vpn-cli
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
  imports = [
    ./hardware-configuration.nix
  ];

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

  # TODO: Prevent exposing hostname from being to wifi networks
  networking = {
    hostName = "nix";
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "stable";
      ethernet.macAddress = "random";
    };
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
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

    kanata = {
      enable = true;
      keyboards.default = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ./kanata/vivobook.kbd;
      };
    };

    ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_IGPU_ENABLE = "1";
      };
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

  systemd = {
    services = {
      fix-vivobook-speakers = {
        description = "Fix TAS2781 speakers.";
        # Re-init the amp on resume: the TAS2781 loses its registers across
        # s2idle. These targets are ordered After=systemd-suspend.service,
        # which only returns once the machine is awake again — so units hung
        # off them run on *resume*. Do not use sleep.target here: it is
        # reached on the way *into* suspend, so the registers get written
        # and then immediately wiped. (post-resume.target does not exist on
        # this system, so the original wanted-by was a silent no-op.)
        after = [
          "multi-user.target"
          "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
          "suspend-then-hibernate.target"
        ];
        wantedBy = [
          "multi-user.target"
          "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
          "suspend-then-hibernate.target"
        ];

        # This provides i2cset to the script environment
        path = [
          pkgs.i2c-tools
          pkgs.bash
        ];

        # This reads the file from your local directory and puts it in the Nix store
        script = builtins.readFile ./fix-speakers.sh;

        serviceConfig = {
          Type = "oneshot";
          # Must NOT remain active after exit: a wanted unit is only started
          # if it is inactive, so a lingering "active (exited)" state would
          # prevent the re-run on the next resume.
          RemainAfterExit = false;
        };
      };
    };
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        google-cursor
        krita
        xournalpp

        (retroarch.withCores (
          cores: with cores; [
            snes9x
            nestopia
            mupen64plus
            genesis-plus-gx
            beetle-psx-hw
          ]
        ))

        localsend
        # TODO: Add Dev Shell to ~/.config and remove these
        nil
        nixfmt
        starship
        qbittorrent
        spotify
        vlc
        mpv
        nautilus
        gcc
      ]
      ++ ai
      ++ browsers
      ++ dmsDeps
      ++ editors
      ++ proton
      ++ terminals
      ++ utils;

    variables = {
      XCURSOR_THEME = "GoogleDot-Blue";
      XCURSOR_SIZE = "21";
      EDITOR = "emacsclient -c -a nvim";
      VISUAL = "emacsclient -c -a nvim";
    };
  };

  system.stateVersion = "26.05";
}

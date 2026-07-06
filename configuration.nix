# RTFM
# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  ...
}:
let
  dmsDeps = with pkgs; [
    cliphist
    dsearch
    cups-pk-helper
    wl-clipboard
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

  networking = {
    hostName = "nix";
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
        after = [
          "multi-user.target"
          "post-resume.target"
        ];
        wantedBy = [
          "multi-user.target"
          "post-resume.target"
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
          # Must NOT remain active after exit: post-resume.target only
          # starts wanted units that are inactive, so a lingering
          # "active (exited)" state prevents the re-run after suspend.
          RemainAfterExit = false;
        };
      };
    };
  };

  environment = {
    systemPackages =
      with pkgs;
      [
        btop
        claude-code
        antigravity-cli
        fd
        fzf
        gh
        ghostty
        git
        google-chrome
        google-cursor
        krita
        localsend
        neovim
        nil
        nixfmt
        proton-vpn
        proton-vpn-cli
        qbittorrent
        ripgrep
        starship
        unzip
        vlc
        zed-editor
      ]
      ++ dmsDeps;

    variables = {
      XCURSOR_THEME = "GoogleDot-Blue";
      XCURSOR_SIZE = "32";
    };
  };

  system.stateVersion = "26.05";
}

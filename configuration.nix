{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware/vivobook.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    kernelModules = [ "i2c-dev" ];
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "vt.global_cursor_default=0"
    ];
  };

  networking = {
    hostName = "vivobook";
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

  services = {
    xserver.enable = true;
    displayManager = {
      gdm = {
        enable = true;
        banner = "Stay hydrated!";
      };
      defaultSession = "niri";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    power-profiles-daemon = {
      enable = true;
    };
    upower = {
      enable = true;
    };
    kanata = {
      enable = true;
      keyboards.default = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ./kanata/vivobook.kbd;
      };
    };
  };
  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

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
    ];
  };

  # GPU Fixes
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
        libvdpau-va-gl
        level-zero
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri.default = [ "gtk" ];
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
      fix-vivobook-speakers = {
        description = "Fix TAS2781 speakers.";
        after = [ "multi-user.target" ];
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
          RemainAfterExit = true;
        };
      };
    };
    tmpfiles.rules =
      let
        username = "yash";
      in
      [
        "f+ /var/lib/AccountsService/users/${username}  0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${username}\\n"
        "L+ /var/lib/AccountsService/icons/${username}  - - - - ${./avatar.jpg}"
      ];
  };

  nixpkgs = {
    overlays = with inputs; [ niri-flake.overlays.niri ];
    config.allowUnfree = true;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      alsa-utils
      bluetui
      brightnessctl
      btop
      claude-code
      copyq
      fd
      firefox
      fuzzel
      fzf
      gcc
      gh
      ghostty
      git
      gnumake
      google-chrome
      i2c-tools
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      kew
      lazygit
      localsend
      marksman
      neovim
      nerd-fonts.jetbrains-mono
      nil
      nodejs_latest
      proton-pass
      proton-pass-cli
      proton-vpn
      proton-vpn-cli
      protonmail-desktop
      qbittorrent
      ripgrep
      sbctl
      starship
      swayidle
      tree-sitter
      unzip
      vlc
      wl-clipboard
      xwayland-satellite
      yazi
      gemini-cli
    ];
  };

  system.stateVersion = "25.05";
}

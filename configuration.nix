{
  pkgs,
  inputs,
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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
  ];

  networking = {
    hostName = "vivobook";
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "02:01:02:03:04:09";
      ethernet.macAddress = "02:01:02:03:04:08";
    };
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  services.displayManager.defaultSession = "niri";
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --greeting 'Stay hydrated!' --cmd niri";
        user = "greeter";
      };
    };
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.power-profiles-daemon = {
    enable = true;
  };
  services.upower = {
    enable = true;
  };

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

  services.kanata = {
    enable = true;
    keyboards.default = {
      devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
      configFile = ./kanata/vivobook.kbd;
    };
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

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.services.fix-vivobook-speakers = {
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

  nixpkgs.overlays = with inputs; [ niri-flake.overlays.niri ];

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

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      xwayland-satellite
      alsa-utils
      bluetui
      brave
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
      i2c-tools # Speaker fix
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
      qbittorrent
      ripgrep
      starship
      tree-sitter
      unzip
      vlc
      wl-clipboard
      yazi
    ];
  };

  system.stateVersion = "25.05";
}

{ config, pkgs, ... }:
{
  # TODO: Host based configuration
  imports = [
    ./hardware/vivobook.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "vivobook";
    networkmanager.enable = true;
    networkmanager.dns = "none";
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
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
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

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Shinde";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # TODO: Host based configuration
  services.kanata = {
    enable = true;
    keyboards.default.configFile = ./kanata/vivobook.kbd;
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;
  programs.niri.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      neovim
    ];
  };

  system.stateVersion = "25.05";
}

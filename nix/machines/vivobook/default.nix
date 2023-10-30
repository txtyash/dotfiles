{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix # Auto generated
  ];

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vivobook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.nameservers = ["9.9.9.9" "1.1.1.1"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
  ];

  environment.variables.EDITOR = "nvim";

  # xdg.mime = {
  #   enable = true;
  #   defaultApplications = {
  #     "application/pdf" = [
  #       "zathura"
  #       webBrowser
  #     ];
  #     "image/png" = [
  #       "nsxiv.desktop"
  #       webBrowser
  #     ];
  #     "text/html" = webBrowser;
  #     "x-scheme-handler/http" = webBrowser;
  #     "x-scheme-handler/https" = webBrowser;
  #     "x-scheme-handler/about" = webBrowser;
  #     "x-scheme-handler/unknown" = webBrowser;
  #     "x-scheme-handler/chrome" = webBrowser;
  #     "application/x-exension-htm" = webBrowser;
  #     "application/x-exension-html" = webBrowser;
  #     "application/x-exension-shtml" = webBrowser;
  #     "application/xhtml+xml" = webBrowser;
  #     "application/x-exension-xhtml" = webBrowser;
  #     "application/x-exension-xht" = webBrowser;
  #   };
  # };

  system.stateVersion = "23.05";
}

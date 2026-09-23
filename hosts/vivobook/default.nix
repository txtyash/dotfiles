{ pkgs, ... }:
let
  proton = with pkgs; [
    proton-vpn
    proton-vpn-cli
  ];
in
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  networking = {
    hostName = "vivobook";
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
  };

  services = {
    kanata = {
      enable = true;
      keyboards.default = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ../../kanata/vivobook.kbd;
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
      with pkgs; [
        qbittorrent
      ]
      ++ proton;
  };

  # DO NOT CHANGE
  system.stateVersion = "26.05";
}

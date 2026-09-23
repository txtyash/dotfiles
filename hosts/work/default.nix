{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  networking = {
    hostName = "work";
    networkmanager = {
      enable = true;
    };
  };

  services = {
    kanata = {
      enable = false;
      keyboards.default = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ../../kanata/thinkpad-p14s.kbd;
      };
    };
  };

  virtualisation.vmware.guest.enable = true;
  zramSwap.enable = true;

  environment = {
    systemPackages =
      with pkgs; [
      	vscode
      ];
  };

  # DO NOT CHANGE
  system.stateVersion = "26.05";
}

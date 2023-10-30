{lib, profile, ...}: let
  mkSettings = (import ../../modules/settings/default.nix {inherit lib;}).mkSettings;
in {
  imports = [./home-manager];
  options = mkSettings profile;
  config = {
    ${profile} = {
      editor = "nvim";
      email = "shindeyash@proton.me";
      workEmail = "evccyr@proton.me";
      neovimColorscheme = "kanagawa";
    };

    nix.settings.trusted-users = [profile];

    users.users.${profile} = {
      isNormalUser = true;
      description = "Yash Shinde.";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
# # ---- SYSTEM SETTINGS ---- #
# system = "x86_64-linux"; # system arch
# hostname = "snowfire"; # hostname
# profile = "personal"; # select a profile defined from my profiles directory
# timezone = "America/Chicago"; # select timezone
# locale = "en_US.UTF-8"; # select locale
#
# # ----- USER SETTINGS ----- #
# username = "emmet"; # username
# name = "Emmet"; # name/identifier
# email = "librephoenix3@pm.me"; # email (used for certain configurations)
# dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
# theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
# wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
# wmType = "wayland"; # x11 or wayland
# browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
# editor = "emacsclient"; # Default editor;
# defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
# term = "alacritty"; # Default terminal command;
# font = "Intel One Mono"; # Selected font
# fontPkg = pkgs.intel-one-mono; # Font package


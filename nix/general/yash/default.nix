{
  lib,
  config,
  ...
}: let
  profile = "yash";
in {
  imports = [../../home-manager];

  config = {
    nix.settings.trusted-users = [profile];
    users.users.${profile} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
    profiles = {
      ${profile} = {
        description = "Yash Shinde";
        editor = "nvim";
        email = "shindeyash@proton.me";
        workEmail = "evccyr@proton.me";
        # Browse here: https://github.com/tinted-theming/base16-schemes
        theme = "gruvbox-dark-medium";
        polarity = "light";
        # Browse here: https://nix-community.github.io/nixvim/colorschemes/ayu.html
        nvimTheme = "kanagawa";
        browser = "chromium";
        term = "wezterm";
      };
    };
  };
}
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


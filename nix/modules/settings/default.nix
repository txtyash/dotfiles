{lib, ...}:
with lib; {
  mkSettings = profile: {
    ${profile} = {
      editor = mkOption {
        type = types.str;
        default = "nvim";
        description = "Default text editor.";
      };
      colorscheme = mkOption {
        type = types.str;
        default = "ayu-light";
        description = "Global colorscheme.";
      };
      polarity = mkOption {
        type = types.str;
        default = "light";
        description = "Global colorscheme type.";
      };
      neovimColorscheme = mkOption {
        type = types.str;
        default = "default";
        description = "Neovim colorscheme.";
      };
      email = mkOption {
        type = types.nullOr types.str;
        description = "Personal user email.";
      };
      workEmail = mkOption {
        type = types.nullOr types.str;
        description = "User's work email.";
      };
    };
  };
}
/*
# ---- SYSTEM SETTINGS ---- #
system = "x86_64-linux"; # system arch
hostname = "snowfire"; # hostname
profile = "personal"; # select a profile defined from my profiles directory
timezone = "America/Chicago"; # select timezone
locale = "en_US.UTF-8"; # select locale

# ----- USER SETTINGS ----- #
username = "emmet"; # username
name = "Emmet"; # name/identifier
email = "librephoenix3@pm.me"; # email (used for certain configurations)
dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
theme = "uwunicorn-yt"; # selcted theme from my themes directory (./themes/)
wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
wmType = "wayland"; # x11 or wayland
browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
editor = "emacsclient"; # Default editor;
defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
term = "alacritty"; # Default terminal command;
font = "Intel One Mono"; # Selected font
fontPkg = pkgs.intel-one-mono; # Font package
*/


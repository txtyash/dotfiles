{lib, ...}:
with lib; let
  settings = {
    options = {
      enable = mkEnableOption;
      description = mkOption {
        type = types.str;
        default = "No profile description.";
        description = "Profile description.";
        example = "John Doe";
      };
      nvimTheme = mkOption {
        type = types.str;
        default = "default";
        description = "Colorscheme for the neovim text editor.";
        # Browse here: https://nix-community.github.io/nixvim/colorschemes/ayu.html
        example = "kanagawa";
      };
      wall = mkOption {
        type = types.path;
        default = ../../../pictures/landscape/default.png;
        description = "Wallpaper.";
        example = "../../../pictures/landscape/default.png";
      };
      theme = mkOption {
        type = types.str;
        # Browse here: https://github.com/tinted-theming/base16-schemes
        default = "ayu-light";
        description = "Stylix theme to apply.";
        example = "ayu-light";
      };
      polarity = mkOption {
        type = types.str;
        default = "light";
        description = "Theme type(light/dark)";
        example = "dark";
      };
      editor = mkOption {
        type = types.str;
        default = "nano";
        description = "Text editor.";
        example = "nvim";
      };
      email = mkOption {
        type = types.nullOr types.str;
        description = "email (used for personal configurations).";
        example = "john@gmail.com";
      };
      workEmail = mkOption {
        type = types.nullOr types.str;
        description = "email (used for work configurations).";
        example = "john@gmail.com";
      };
      wmType = mkOption {
        type = types.str;
        default = "wayland";
        description = "Window manager type.";
        example = "x11";
      };
      wm = mkOption {
        type = types.str;
        default = "hyprland";
        description = "Window manager.";
        example = "sway";
      };
      browser = mkOption {
        type = types.str;
        default = "chromium";
        # Browse nix packages here: https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=firefox
        description = "Web Browser";
        example = "microsoft-edge";
      };
      term = mkOption {
        type = types.str;
        default = "wezterm";
        description = "Terminal emulator";
        example = "alacritty";
      };
      font = mkOption {
        type = types.str;
        default = "DejaVu Serif";
        description = "Font";
        example = "DejavVu Sans";
      };
      fontPkg = mkOption {
        type = types.package;
        default = pkgs.dejavu_fonts;
        description = "Font Package";
      };
    };
  };
in {
  options = {
    profiles = mkOption {
      type = types.attrsOf (types.submoduleWith {
        modules = [settings];
      });
    };
  };
}
# # ---- SYSTEM SETTINGS ---- #
# system = "x86_64-linux"; # system arch
# hostname = "snowfire"; # hostname
# profile = "personal"; # select a profile defined from my profiles directory
# timezone = "America/Chicago"; # select timezone
# locale = "en_US.UTF-8"; # select locale


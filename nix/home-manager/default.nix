{
  pkgs,
  inputs,
  ...
}:
with inputs; {
  # Home manager: Installing packages & Managing configs
  imports = [home-manager.nixosModules.home-manager];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yash = {
      # Let home Manager install and manage itself.
      programs.home-manager.enable = true;
      home.username = "yash";
      home.homeDirectory = "/home/yash";
      home.stateVersion = "23.05";
      home.sessionVariables = {
        EDITOR = "nvim";
        # TODO git template dir
      };
      home.packages = with pkgs; [
        # GUI
        fuzzel # wayland application launcher

        # TUI
        bat # gnu cat replacement
        bottom # system monitor
        broot # file tree application
        evcxr # rust repl
        eza # A modern replacement for ‘ls’
        fd # find replacement
        file # nixos does not have a file command by default
        fzf # A command-line fuzzy finder
        gh # github cli
        gnupg # gnu privacy guard(encryption tool)
        kanata # advanced key mapper
        lazygit # git tui frontend
        ncdu # ncurses disk usage
        nerdfonts # collection of patched fonts
        ripgrep # grep replacement
        sd # sed replacement
        unzip # archives
        wl-clipboard # wayland clipboard
        yazi # tui file manager
        zip # archives
      ];
      imports = [
        nixvim.homeManagerModules.nixvim
        stylix.homeManagerModules.stylix
        ../fish
        ../neovim
        ../starship
        ../stylix
        ../wezterm
        ../zoxide
      ];
    };
  };
}

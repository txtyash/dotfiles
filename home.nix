{ config, pkgs, ... }:
{
  home = {
	username = "yash";
	homeDirectory = "/home/yash";
	stateVersion = "25.05";
	packages = with pkgs; [
	  gh
	  brave
	  niri
	  nil
	  dprint
	  marksman
	  fuzzel
	  yazi
	  ripgrep
	  fd
	  zoxide
	  neovide
	];
  };

  programs = {
	git = {
	  enable = true;
	  userName = "txtyash";
	  userEmail = "textyash@proton.me";
	};

	starship = {
	  enable = true;
	  settings = {
		add_newline = false;
		line_break.disabled = true;
	  };
	};

	fish = {
	  enable = true;
	};

	ghostty = {
	  enable = true;
	  enableFishIntegration = true;
	};
  };
}

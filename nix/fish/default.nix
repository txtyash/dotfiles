{ pkgs, ... }:
let
	fishConfig = ''
		set -g EDITOR (which nvim)
		set -g VISUAL (which nvim)
		set fish_greeting ""

		if status is-interactive
		    fish_vi_key_bindings
		    function fish_user_key_bindings
			for mode in default insert
			    bind -M $mode \cz "fg %(jobs | fzf | cut -c1)"
			    bind -M $mode \cc cancel-cmd
			    bind -M $mode \cp history-search-backward
			    bind -M $mode \cn history-search-forward
			    bind -M $mode \ca beginning-of-buffer
			    bind -M $mode \ce end-of-buffer forward-char
			    bind -M $mode \cw backward-kill-word
			    bind -M $mode \ef forward-word
			    bind -M $mode \eh _atuin_search
			    bind -M $mode \ee $EDITOR .
			end
		    end
		end

		function cancel-cmd
		    commandline ""
		    emit fish_cancel
		    commandline -f repaint
		end

		fzf_configure_bindings --directory=\cf --history=\cr
	'';
in
{
	programs.fish = {
		enable = true;
		plugins = [
			{ name = "done"; src = pkgs.fishPlugins.done.src; }
			{ name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
			{ name = "fzf.fish"; src = pkgs.fishPlugins.fzf-fish.src; }
			{ name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
		];

		shellAliases = {
			l="eza";
			ll="eza -l";
			la="eza -la";
			d="z";
			di="zi";
			dp="cd -";
			top="btm";
		};

		shellInit = fishConfig;

		interactiveShellInit = ''
			zoxide init fish | source
			starship init fish | source
			atuin init fish | source
		'';
			
	};
}


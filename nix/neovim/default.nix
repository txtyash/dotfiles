{ pkgs, lib, ... }:
{
	programs.neovim = {
		enable = true;
		extraLuaConfig = lib.fileContents ../../.config/nvim/init.lua;	
		plugins = with pkgs.vimPlugins; [
		   nvim-treesitter.withAllGrammars
		 ];
		 defaultEditor = true;
	};
}



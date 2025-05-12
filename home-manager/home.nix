{ config, pkgs, ... }:

{
	imports = [
		./apps/zsh.nix 
		./apps/micro.nix
	];
	home.username = "surya";
	home.homeDirectory = "/home/surya";
	home.stateVersion = "23.05";
	home.packages = with pkgs; [
			# Rust CLI Tools! I love rust.
			bat
			tokei
			fd
			nix
			rustup
			gcc
			eza

			# Development
			neovim
			tmux
			warp
			jq
			git-crypt
			pnpm
			nodejs_20
			oh-my-zsh
			# Files
			zstd
			restic

			# Overview
			htop
			wtfutil
			lazygit
			neofetch

			# Jokes
			fortune
			figlet
			lolcat

			#media
			vlc
			];
	programs.git = {
		enable = true;
		userEmail = "s.kant@outlook.com";
		userName = "Suryakant";
		signing.key = "E655E84F28A40E67";
		signing.signByDefault = true;
	};
	programs.zsh = {
		enable = true;
		dotDir = ".config/zsh";
		envExtra = ''
    		EDITOR=nvim
		NODE_OPTIONS=--max_old_space_size=8192
  		'';
		shellAliases = {
			l="eza";
			la="eza -a";
			ll="eza -lah";
			ls="eza --color=auto";
   		   	ip = "ip --color=auto";
   		 };
	};
	programs.home-manager.enable = true;
}

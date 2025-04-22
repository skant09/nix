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

    # Development
    neovim
    tmux
    warp
    jq
    git-crypt

    # Files
    zstd
    restic

    # Overview
    htop
    wtf
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
  programs.home-manager.enable = true;
}

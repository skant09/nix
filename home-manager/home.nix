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
  ];
  programs.git = {
    enable = true;
    userEmail = "s.kant@outlook.com";
    userName = "Suryakant";
    signing.key = "738A0BE6D8D8AE7D";
    signing.signByDefault = true;
  };
  programs.home-manager.enable = true;
}

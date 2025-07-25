{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
    let
      configuration = { pkgs, ... }: {

        # Disable nix-darwin's Nix management for Determinate compatibility
        nix.enable = false;

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog 
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an older system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.config.allowUnfree = true;


        # Set primary user for homebrew and other user-specific options
        system.primaryUser = "suryakant";

        # Declare the user that will be running `nix-darwin`.
        users.users.suryakant = {
          name = "suryakant";
          home = "/Users/suryakant";
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        # Create /etc/zshrc that loads the nix-darwin environment. 
        programs.zsh.enable = true;
        environment.systemPackages = with pkgs; [
          neofetch
          pnpm
          nodePackages.pnpm
          notion-app
          nodejs_20
        ];

        homebrew = {
          enable = true;
          # onActivation.cleanup = "uninstall";
          taps = [];
          brews = [
            "awscli"
            "redis"
            "python3"
            "hashicorp/tap/terraform"
          ];
          casks = ["brave-browser" "postman" "raycast" "zoom" "onlyoffice"];
        };
      };
      homeconfig = {pkgs, ...}: {
        # this is internal compatibility configuration 
        # for home-manager, don't change this!
        home.stateVersion = "23.05";
        # Let home-manager install and manage itself.
        programs.home-manager.enable = true;

        home.packages = with pkgs; [];

        home.sessionVariables = {
          EDITOR = "vim";
        };
        programs.vscode = {
          enable = true;
        };
      };
    in
      {
      darwinConfigurations."Suryakants-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.suryakant = homeconfig;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    };
}

{
  description = "My NixOS configuration managed with flakes";
  darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";       # Main NixOS package source
    home-manager.url = "github:nix-community/home-manager";   # Home Manager integration
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, ... } @ inputs: 
   let 
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
    in
    {
    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/homelab/configuration.nix       # NixOS system-level config
          ./hosts/homelab/services/open-webui.nix # Service: Open WebUI
          ./hosts/homelab/services/home-assistant.nix # Service: Home Assistant
          home-manager.nixosModules.home-manager  # Enable Home Manager
          {
            home-manager.users.daniel = import ./shared/home.nix; # User config for 'daniel'
          }
        ];
      };
    };
    darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system: darwin.lib.darwinSystem {
      inherit system;
      specialArgs = inputs;
      modules = [
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "daniel";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;
            autoMigrate = true;
          };
        }
        ./hosts/darwin
      ];
    });
  };
}

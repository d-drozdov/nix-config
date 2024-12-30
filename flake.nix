{
  description = "My NixOS configuration managed with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Main NixOS package source
    home-manager.url = "github:nix-community/home-manager"; # Home Manager integration

    # Mac Stuff
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure Darwin follows the nixpkgs source
    };

    # Homebrew stuff
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
    fuse-t-cask = {
      url = "github:macos-fuse-t/homebrew-cask";
      flake = false;
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      ...
    }@inputs:
    {
      # NixOS configurations
      nixosConfigurations = {
        homelab = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/homelab/configuration.nix # NixOS system-level config
            ./hosts/homelab/services/open-webui.nix # Service: Open WebUI
            ./hosts/homelab/services/home-assistant.nix # Service: Home Assistant
            home-manager.nixosModules.home-manager # Enable Home Manager
            {
              home-manager.users.daniel = import ./hosts/homelab/home-manager.nix; # User config for 'daniel'
            }
          ];
        };
      };

      # Darwin configurations (macOS)
      darwinConfigurations = {
        darwin = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # Target system architecture (Apple Silicon)

          specialArgs = inputs;

          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            ./hosts/darwin # Include additional macOS configuration
          ];
        };
      };
    };
}
